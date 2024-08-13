import 'package:markdown_writer/src/markdown.dart';
import 'package:markdown_writer/src/markdown_entry.dart';

abstract class ListEntryPrefix {
  Markdown build(String orderedIndex);
  bool get isExpandable;
}

enum UnorderedListPrefixType implements MarkdownEntry {
  minus,
  plus,
  asterisk;

  @override
  Markdown toMarkdown() {
    return switch (this) {
      UnorderedListPrefixType.minus => '-',
      UnorderedListPrefixType.plus => '+',
      UnorderedListPrefixType.asterisk => '*',
    };
  }
}

final class UnorderedListPrefix implements ListEntryPrefix {
  final UnorderedListPrefixType type;

  const UnorderedListPrefix({required this.type});

  @override
  Markdown build(String orderedIndex) {
    return type.toMarkdown();
  }

  @override
  bool get isExpandable => false;
}

final class OrderedListPrefix implements ListEntryPrefix {
  @override
  Markdown build(String orderedIndex) {
    return '$orderedIndex.';
  }

  @override
  bool get isExpandable => true;
}

class ListEntry implements MarkdownEntry {
  final Markdown text;
  final ListEntryPrefix prefix;
  final List<ListEntry> children;
  final String indentation;

  const ListEntry({
    required this.text,
    required this.prefix,
    this.children = const [],
    this.indentation = '  ',
  });

  @override
  Markdown toMarkdown({String level = '1', int indentationLevel = 0}) {
    final indent = indentation * indentationLevel;
    final item = '$indent${prefix.build(level.toString())} $text';

    if (children.isEmpty) {
      return item;
    }

    return '$item\n${children.indexed.map((indexedChild) {
      final (index, child) = indexedChild;
      final nextLevel =
          switch (prefix.isExpandable && child.prefix.isExpandable) {
        true => '$level.${index + 1}',
        false => '${index + 1}',
      };

      return child.toMarkdown(
        level: nextLevel,
        indentationLevel: indentationLevel + 1,
      );
    }).join('\n')}';
  }
}

final class TaskListEntry extends ListEntry {
  const TaskListEntry({
    required Markdown text,
    required bool isCompleted,
    required super.prefix,
    super.children,
    super.indentation,
  }) : super(
          text: '[${isCompleted ? 'x' : ' '}] $text',
        );
}

class MarkdownList implements MarkdownEntry {
  final List<ListEntry> entries;

  const MarkdownList({this.entries = const []});

  @override
  Markdown toMarkdown() {
    return entries.indexed.map((indexedEntry) {
      final (index, entry) = indexedEntry;
      return entry.toMarkdown(level: (index + 1).toString());
    }).join('\n');
  }
}
