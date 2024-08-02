import 'package:markdown_writer/markdown_writer.dart';

enum MarkdownAlertType {
  note,
  tip,
  important,
  warning,
  caution;

  Markdown toMarkdown() {
    return switch (this) {
      MarkdownAlertType.note => '[!NOTE]',
      MarkdownAlertType.tip => '[!TIP]',
      MarkdownAlertType.important => '[!IMPORTANT]',
      MarkdownAlertType.warning => '[!WARNING]',
      MarkdownAlertType.caution => '[!CAUTION]',
    };
  }
}
