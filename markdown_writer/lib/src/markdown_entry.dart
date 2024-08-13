import 'package:markdown_writer/src/markdown.dart';

abstract interface class MarkdownEntry {
  Markdown toMarkdown();
}

extension InlinedMarkdownEntry on MarkdownEntry {
  Markdown operator +(MarkdownEntry entry) {
    return entry.toMarkdown();
  }
}
