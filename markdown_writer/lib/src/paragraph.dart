import 'package:markdown_writer/src/markdown.dart';
import 'package:markdown_writer/src/markdown_entry.dart';

class Paragraph implements MarkdownEntry {
  final Markdown text;

  const Paragraph(this.text);

  @override
  Markdown toMarkdown() {
    return text;
  }
}
