import 'package:markdown_writer/markdown_writer.dart';

abstract interface class ListItemIndicator {
  Markdown toMarkdown(String index);
}

final class OrderedListItemIndicator implements ListItemIndicator {
  const OrderedListItemIndicator();

  @override
  Markdown toMarkdown(String index) => '$index.';
}

enum UnorderedListItemIndicator implements ListItemIndicator {
  asterisk,
  minus,
  plus;

  @override
  Markdown toMarkdown(String index) {
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
  final Iterable<ListItem> children;

  const ListItem(
    this.message, {
    this.indicator = UnorderedListItemIndicator.asterisk,
    this.children = const [],
  });

  Markdown toMarkdown({
    required String index,
    int indentation = 0,
  }) {
    final node = '${'  ' * indentation}${indicator.toMarkdown(index)} $message';
    final nestedChildren = children.indexed.map((entry) {
      final (childIndex, child) = entry;
      return child.toMarkdown(
        index: '$index.${childIndex + 1}',
        indentation: indentation + 1,
      );
    });

    return [node, ...nestedChildren].join('\n');
  }
}

final class TaskListItem extends ListItem {
  const TaskListItem(
    String message, {
    ListItemIndicator indicator = UnorderedListItemIndicator.asterisk,
    Iterable<ListItem> children = const [],
    required bool isChecked,
  }) : super(
          '[${isChecked ? 'x' : ' '}] $message',
          indicator: indicator,
          children: children,
        );
}
