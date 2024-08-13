import 'package:markdown_writer/src/list.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('List', () {
    test('Should produce a single list item', () {
      final list = ListEntry(
        text: 'This is a list item',
        prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
      );

      expect(list.toMarkdown(), equals('+ This is a list item'));
    });

    test('Should produce a nested list item', () {
      final list = ListEntry(
        text: 'This is a list item',
        prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
        children: [
          ListEntry(
            text: 'This is a nested list item',
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.asterisk),
          ),
          ListEntry(
            text: 'This is a nested list item',
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
          ),
          ListEntry(
            text: 'This is a nested list item',
            prefix: OrderedListPrefix(),
          ),
        ],
      );

      expect(
        list.toMarkdown(),
        equals(
          '+ This is a list item\n  * This is a nested list item\n  + This is a nested list item\n  3. This is a nested list item',
        ),
      );
    });

    test('Should produce a basic list', () {
      final list = MarkdownList(
        entries: [
          ListEntry(
            text: 'This is a list item',
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
          ),
          ListEntry(
            text: 'This is a list item',
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.asterisk),
          ),
          ListEntry(
            text: 'This is a list item',
            prefix: OrderedListPrefix(),
          ),
        ],
      );

      expect(
        list.toMarkdown(),
        equals(
          '+ This is a list item\n* This is a list item\n3. This is a list item',
        ),
      );
    });

    test('Should produce a list with nested children', () {
      final list = MarkdownList(
        entries: [
          ListEntry(
            text: 'This is a list item',
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
            children: [
              ListEntry(
                text: 'This is a nested list item',
                prefix:
                    UnorderedListPrefix(type: UnorderedListPrefixType.asterisk),
              ),
              ListEntry(
                text: 'This is a nested list item',
                prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
              ),
              ListEntry(
                text: 'This is a nested list item',
                prefix: OrderedListPrefix(),
              ),
            ],
          ),
          ListEntry(
            text: 'This is a list item',
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.asterisk),
          ),
          ListEntry(
            text: 'This is a list item',
            prefix: OrderedListPrefix(),
          ),
        ],
      );

      expect(
        list.toMarkdown(),
        equals(
          '+ This is a list item\n  * This is a nested list item\n  + This is a nested list item\n  3. This is a nested list item\n* This is a list item\n3. This is a list item',
        ),
      );
    });

    test('Should produce simple ordered list', () {
      final list = MarkdownList(
        entries: [
          ListEntry(
            text: 'This is a list item',
            prefix: OrderedListPrefix(),
          ),
          ListEntry(
            text: 'This is a list item',
            prefix: OrderedListPrefix(),
          ),
          ListEntry(
            text: 'This is a list item',
            prefix: OrderedListPrefix(),
          ),
        ],
      );

      expect(
        list.toMarkdown(),
        equals(
            '1. This is a list item\n2. This is a list item\n3. This is a list item'),
      );
    });

    parameterizedTest(
      'Should produce simple unordered list',
      [
        const [
          MarkdownList(
            entries: [
              ListEntry(
                text: 'This is a list item',
                prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
              ),
              ListEntry(
                text: 'This is a list item',
                prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
              ),
              ListEntry(
                text: 'This is a list item',
                prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
              ),
            ],
          ),
          '+ This is a list item\n+ This is a list item\n+ This is a list item',
        ],
        const [
          MarkdownList(
            entries: [
              ListEntry(
                text: 'This is a list item',
                prefix:
                    UnorderedListPrefix(type: UnorderedListPrefixType.asterisk),
              ),
              ListEntry(
                text: 'This is a list item',
                prefix:
                    UnorderedListPrefix(type: UnorderedListPrefixType.asterisk),
              ),
              ListEntry(
                text: 'This is a list item',
                prefix:
                    UnorderedListPrefix(type: UnorderedListPrefixType.asterisk),
              ),
            ],
          ),
          '* This is a list item\n* This is a list item\n* This is a list item',
        ],
        const [
          MarkdownList(
            entries: [
              ListEntry(
                text: 'This is a list item',
                prefix:
                    UnorderedListPrefix(type: UnorderedListPrefixType.minus),
              ),
              ListEntry(
                text: 'This is a list item',
                prefix:
                    UnorderedListPrefix(type: UnorderedListPrefixType.minus),
              ),
              ListEntry(
                text: 'This is a list item',
                prefix:
                    UnorderedListPrefix(type: UnorderedListPrefixType.minus),
              ),
            ],
          ),
          '- This is a list item\n- This is a list item\n- This is a list item',
        ],
      ],
      (MarkdownList list, String expected) {
        expect(list.toMarkdown(), equals(expected));
      },
    );

    test('Should produce tasklist', () {
      final list = MarkdownList(
        entries: [
          TaskListEntry(
            text: 'This is a task item',
            isCompleted: true,
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.minus),
          ),
          TaskListEntry(
            text: 'This is a task item',
            isCompleted: false,
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.minus),
          ),
          TaskListEntry(
            text: 'This is a task item',
            isCompleted: true,
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
          ),
          TaskListEntry(
            text: 'This is a task item',
            isCompleted: true,
            prefix: OrderedListPrefix(),
          ),
        ],
      );

      expect(
        list.toMarkdown(),
        equals(
          '- [x] This is a task item\n- [ ] This is a task item\n+ [x] This is a task item\n4. [x] This is a task item',
        ),
      );
    });

    test('Should created nested tasklist', () {
      final list = MarkdownList(
        entries: [
          TaskListEntry(
            text: 'This is a task item',
            isCompleted: true,
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.minus),
            children: [
              TaskListEntry(
                text: 'This is a nested task item',
                isCompleted: true,
                prefix:
                    UnorderedListPrefix(type: UnorderedListPrefixType.asterisk),
              ),
              TaskListEntry(
                text: 'This is a nested task item',
                isCompleted: false,
                prefix: UnorderedListPrefix(type: UnorderedListPrefixType.plus),
              ),
              TaskListEntry(
                text: 'This is a nested task item',
                isCompleted: true,
                prefix: OrderedListPrefix(),
              ),
            ],
          ),
          TaskListEntry(
            text: 'This is a task item',
            isCompleted: true,
            prefix: UnorderedListPrefix(type: UnorderedListPrefixType.asterisk),
          ),
          TaskListEntry(
            text: 'This is a task item',
            isCompleted: false,
            prefix: OrderedListPrefix(),
          ),
        ],
      );

      expect(
        list.toMarkdown(),
        equals(
          '- [x] This is a task item\n  * [x] This is a nested task item\n  + [ ] This is a nested task item\n  3. [x] This is a nested task item\n* [x] This is a task item\n3. [ ] This is a task item',
        ),
      );
    });
  });
}
