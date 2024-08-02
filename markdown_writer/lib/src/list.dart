import 'package:markdown_writer/markdown_writer.dart';

abstract interface class ListItemIndicator {
  Markdown toMarkdown(int index);
}

final class OrderedListItemIndicator implements ListItemIndicator {
  final int offset;

  const OrderedListItemIndicator([this.offset = 1]);

  @override
  Markdown toMarkdown(int index) => '${offset + index}.';
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
    };
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

  Markdown toMarkdown(int index) {
    final indentationString = '  ' * indentation;
    final indicatorString = indicator.toMarkdown(index);
    return '$indentationString$indicatorString $message';
  }
}

final class TaskListItem extends ListItem {
  final bool isChecked;
  const TaskListItem(
    super.message, {
    super.indicator,
    super.indentation,
    required this.isChecked,
  });

  @override
  Markdown toMarkdown(int index) {
    final indentationString = '  ' * indentation;
    final indicatorString = indicator.toMarkdown(index);
    final isCheckedString = isChecked ? 'x' : ' ';
    return '$indentationString$indicatorString [$isCheckedString] $message';
  }
}
