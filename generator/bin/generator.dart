import 'dart:convert';
import 'dart:io' as io;

import 'package:dart_pubspec_licenses/dart_pubspec_licenses.dart' as oss;
import 'package:generator/license_details.dart';
import 'package:generator/markdown/standard_markdown_writer.dart';
import 'package:generator/markdown_generator.dart';
import 'package:path/path.dart' as path;

void main(List<String> args) async {
  final projectRoot = args.isEmpty ? '.' : args.first;
  final licensesJson = args.length > 1 ? args[1] : '../licenses.json';

  print('Reading licenses from "$licensesJson"');
  final licensesFile = io.File(licensesJson);
  if (!await licensesFile.exists()) {
    print('File "$licensesJson" not found');
    io.exit(1);
  }

  final licensesJsonContent = await licensesFile.readAsString();
  final licensesList = jsonDecode(licensesJsonContent) as Map<String, dynamic>;
  final licenses = licensesList['licenses'] as List<dynamic>;
  final licenseDetails =
      licenses.map((entry) => LicenseDetails.fromJson(entry)).toList();

  print('Generating project in "$projectRoot" with "$licensesJson"');

  final pubspecLockPath = path.join(projectRoot, 'pubspec.lock');
  final pubspecLockFile = io.File(pubspecLockPath);

  if (!await pubspecLockFile.exists()) {
    print('pubspec.lock not found. Run "pub get" first.');
    io.exit(1);
  }

  final projectDependencies = await oss.listDependencies(
    pubspecLockPath: pubspecLockPath,
  );

  print('Resolved ${projectDependencies.allDependencies.length} dependencies');

  final markdownFile = await io.File(path.join(projectRoot, 'DEPENDENCIES.md'))
      .create(recursive: true);

  print('Created DEPENDENCIES.md');

  final writer = StandardMarkdownWriter();
  final markdownContent = writeDependenciesFile(
    writer,
    licenseDetails,
    projectDependencies,
  );
  await markdownFile.writeAsString(markdownContent);
}
