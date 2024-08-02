import 'package:markdown_writer/markdown_writer.dart';

final class MarkdownTextLink {
  final String link;
  final String? tooltip;

  const MarkdownTextLink(this.link, {this.tooltip});

  Markdown toMarkdown(Markdown text) {
    final brackets = '[$text]';
    final tooltipAddition = tooltip != null ? ' "$tooltip"' : '';
    final linkAddition = '($link$tooltipAddition)';

    return '$brackets$linkAddition';
  }
}

final class MarkdownImageLink {
  final String link;
  final String? tooltip;

  const MarkdownImageLink(this.link, {this.tooltip});

  Markdown toMarkdown(String? alternativeText) {
    final brackets = '[${alternativeText ?? ''}]';
    final tooltipAddition = tooltip != null ? ' "$tooltip"' : '';
    final linkAddition = '($link$tooltipAddition)';

    return '!$brackets$linkAddition';
  }
}
