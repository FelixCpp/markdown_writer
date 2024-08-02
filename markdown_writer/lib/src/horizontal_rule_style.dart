import 'package:markdown_writer/markdown_writer.dart';

enum HorizontalRuleStyle {
  asterisk,
  dash,
  underscore;

  Markdown toMarkdown(int count) {
    return switch (this) {
      HorizontalRuleStyle.asterisk => '*' * count,
      HorizontalRuleStyle.dash => '-' * count,
      HorizontalRuleStyle.underscore => '_' * count,
    };
  }
}
