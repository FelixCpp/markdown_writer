import 'package:dart_pubspec_licenses/dart_pubspec_licenses.dart' as oss;
import 'package:generator/license_details.dart';
import 'package:generator/markdown/markdown.dart';
import 'package:generator/markdown/markdown_writer.dart';

Markdown writeDependenciesFile(
  MarkdownWriter writer,
  List<LicenseDetails> knownLicenses,
  oss.AllProjectDependencies projectDependencies,
) {
  final buffer = <Markdown>[];

  buffer
    ..add(writer.writeH1('Project Dependency Table\n'))
    ..add(_writeLicensesTable(writer, knownLicenses, projectDependencies))
    ..add(writer.writeH2('Dependencies'));

  for (final dependency in projectDependencies.allDependencies) {
    buffer
      ..add(writer.writeH3(dependency.name))
      ..add(writer.writeParagraph(dependency.description));
  }

  return buffer.reduce((value, element) => Markdown(value + element));
}

Markdown _writeLicensesTable(
  MarkdownWriter writer,
  List<LicenseDetails> knownLicenses,
  oss.AllProjectDependencies projectDependencies,
) {
  final headlines = ['Package', 'Version', 'License'];
  final rows = <List<String>>[];

  for (final dependency in projectDependencies.allDependencies) {
    final license = knownLicenses.firstWhere(
      (license) => dependency.license?.contains(license.name) ?? false,
      orElse: () => LicenseDetails.unknown,
    );

    final licenseWebsite = license.websiteUrl;
    final licenseBadge = license.badgeUrl;

    rows.add([
      dependency.name,
      dependency.version,
      if (licenseWebsite != null && licenseBadge != null)
        writer.writeUrl(
          writer.writeImage(license.name, licenseBadge).value,
          licenseWebsite,
        )
    ]);
  }

  return writer.writeTable(headlines, rows);
}
