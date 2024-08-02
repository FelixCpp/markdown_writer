import 'package:markdown_writer/src/markdown.dart';

enum MarkdownTableAlignment {
  none,
  left,
  right,
  center;

  Markdown toMarkdown() {
    return switch (this) {
      MarkdownTableAlignment.none => '---',
      MarkdownTableAlignment.left => ':---',
      MarkdownTableAlignment.right => '---:',
      MarkdownTableAlignment.center => ':---:',
    }
        .toMarkdown();
  }
}

final class MarkdownHeader {
  final Markdown header;
  final MarkdownTableAlignment alignment;

  const MarkdownHeader(this.header, this.alignment);
}

enum HorizontalRuleStyle {
  asterisks,
  dashes,
  underscores,
}

final class MarkdownTextLink {
  final String link;
  final String? tooltip;

  const MarkdownTextLink(this.link, {this.tooltip});

  Markdown toMarkdown(Markdown text) {
    final brackets = '[$text]';
    final tooltipAddition = tooltip != null ? ' "$tooltip"' : '';
    final linkAddition = '($link$tooltipAddition)';

    return '$brackets$linkAddition'.toMarkdown();
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

    return '!$brackets$linkAddition'.toMarkdown();
  }
}

abstract interface class ListItemIndicator {
  Markdown toMarkdown(int index);
}

final class OrderedListItemIndicator implements ListItemIndicator {
  final int offset;

  const OrderedListItemIndicator([this.offset = 1]);

  @override
  Markdown toMarkdown(int index) => '${offset + index}.'.toMarkdown();
}

enum UnorderedListItemIndicator implements ListItemIndicator {
  asterisk,
  minus,
  plus;

  @override
  Markdown toMarkdown(int index) {
    return switch (this) {
      UnorderedListItemIndicator.asterisk => '*',
      UnorderedListItemIndicator.minus => '-',
      UnorderedListItemIndicator.plus => '+',
    }
        .toMarkdown();
  }
}

final class ListItem {
  final Markdown message;
  final ListItemIndicator indicator;
  final int indentation;

  const ListItem(
    this.message, {
    this.indicator = UnorderedListItemIndicator.asterisk,
    this.indentation = 0,
  });
}

final class TaskListItem extends ListItem {
  final bool isChecked;
  const TaskListItem(
    super.message, {
    super.indicator,
    super.indentation,
    required this.isChecked,
  });
}

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
    }
        .toMarkdown();
  }
}

enum HeadlineSyntax { core, alternative }

enum CodeFenceStyle {
  tripleBackticks,
  tilde;

  Markdown toMarkdown() {
    return switch (this) {
      CodeFenceStyle.tripleBackticks => '```',
      CodeFenceStyle.tilde => '~~~',
    }
        .toMarkdown();
  }
}

abstract interface class MarkdownWriter {
  Markdown h1(
    Markdown message, {
    String? id,
    HeadlineSyntax syntax = HeadlineSyntax.core,
  });
  Markdown h2(
    Markdown message, {
    String? id,
    HeadlineSyntax syntax = HeadlineSyntax.core,
  });
  Markdown h3(Markdown message, {String? id});
  Markdown h4(Markdown message, {String? id});
  Markdown h5(Markdown message, {String? id});
  Markdown h6(Markdown message, {String? id});

  Markdown p(String message);
  Markdown bold(Markdown message);
  Markdown italic(Markdown message);
  Markdown boldItalic(Markdown message);
  Markdown highlight(Markdown message);
  Markdown strikeThrough(Markdown message);

  Markdown coded(Markdown message);
  Markdown code(
    String message, {
    String? language,
    CodeFenceStyle style = CodeFenceStyle.tripleBackticks,
  });

  Markdown blockQuote(Iterable<Markdown> lines);
  Markdown horizontalRule(HorizontalRuleStyle style);
  Markdown admonition(String type);
  Markdown alert(MarkdownAlertType type, Iterable<Markdown> lines);
  Markdown comment(String commentName, String message);

  Markdown link(MarkdownTextLink link, [Markdown? message]);
  Markdown image(MarkdownImageLink link, [String? message]);

  Markdown table(
    List<MarkdownHeader> headers,
    List<List<String>> rows,
  );

  Markdown list(List<ListItem> items);
  Markdown taskList(List<TaskListItem> items);
}
