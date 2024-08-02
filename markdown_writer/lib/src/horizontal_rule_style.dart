import 'package:markdown_writer/markdown_writer.dart';

enum HorizontalRuleStyle {
  asterisks,
  dashes,
  underscores;

  Markdown toMarkdown() {
    return switch (this) {
      HorizontalRuleStyle.asterisks => '***',
      HorizontalRuleStyle.dashes => '---',
      HorizontalRuleStyle.underscores => '___',
    };
  }
}
