import 'package:markdown_writer/src/markdown.dart';
import 'package:markdown_writer/src/markdown_entry.dart';

abstract interface class MarkdownWriter implements MarkdownEntry {
  void add(MarkdownEntry entry);
}

final class BufferingMarkdownWriter implements MarkdownWriter {
  final List<MarkdownEntry> _entries = [];

  @override
  void add(MarkdownEntry entry) {
    _entries.add(entry);
  }

  @override
  Markdown toMarkdown() {
    return _entries.map((entry) => entry.toMarkdown()).join('\n');
  }
}
