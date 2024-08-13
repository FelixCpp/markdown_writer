import 'package:markdown_writer/src/markdown.dart';
import 'package:markdown_writer/src/markdown_entry.dart';

final class Term implements MarkdownEntry {
  final Markdown text;
  final List<Markdown> definitions;
  final String definitionSeparator;

  const Term(
    this.text, {
    required this.definitions,
    this.definitionSeparator = '\n',
  });

  @override
  Markdown toMarkdown() {
    return '$text\n: ${definitions.map((definition) => ': $definition').join(definitionSeparator)}';
  }
}
