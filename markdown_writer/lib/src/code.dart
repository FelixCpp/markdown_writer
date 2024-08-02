import 'package:markdown_writer/markdown_writer.dart';

enum CodeFenceStyle {
  tripleBackticks,
  tilde;

  Markdown toMarkdown() {
    return switch (this) {
      CodeFenceStyle.tripleBackticks => '```',
      CodeFenceStyle.tilde => '~~~',
    };
  }
}
