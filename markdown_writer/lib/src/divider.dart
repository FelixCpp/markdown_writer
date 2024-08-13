import 'package:markdown_writer/src/markdown.dart';
import 'package:markdown_writer/src/markdown_entry.dart';

enum DividerSyntax implements MarkdownEntry {
  hyphens,
  asterisks,
  underscores;

  @override
  Markdown toMarkdown() {
    return switch (this) {
      DividerSyntax.hyphens => '-',
      DividerSyntax.asterisks => '*',
      DividerSyntax.underscores => '_'
    };
  }
}

final class Divider implements MarkdownEntry {
  final DividerSyntax syntax;
  final int count;

  const Divider({required this.syntax, required this.count})
      : assert(count >= 3, 'count must be at least 3 for a valid divider');

  @override
  Markdown toMarkdown() {
    return syntax.toMarkdown() * count;
  }
}
