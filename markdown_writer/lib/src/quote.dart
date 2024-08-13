import 'package:markdown_writer/src/markdown.dart';
import 'package:markdown_writer/src/markdown_entry.dart';

final class Quote implements MarkdownEntry {
  final Markdown text;
  final int indentation;

  const Quote(this.text, {this.indentation = 1});

  @override
  Markdown toMarkdown() {
    return '${'>' * indentation} $text';
  }
}
