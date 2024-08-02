import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  parameterizedGroup(
    'MarkdownWriter - Lists',
    [DefaultMarkdownWriter()],
    (MarkdownWriter writer) {
      parameterizedTest(
        'should nested write ordered list',
        [
          [
            ListItem(
              'Item 1',
              indicator: OrderedListItemIndicator(),
              children: [
                ListItem('Item 1.1', indicator: OrderedListItemIndicator()),
                ListItem('Item 1.2', indicator: OrderedListItemIndicator()),
              ],
            ),
            '1. Item 1\n'
                '  1.1. Item 1.1\n'
                '  1.2. Item 1.2',
          ],
        ],
        (ListItem item, String output) {
          final result = writer.list([item]);
          expect(result, equals(output));
        },
      );

      parameterizedTest(
        'should write unordered list',
        [
          [
            ListItem(
              'Item 1',
              indicator: UnorderedListItemIndicator.asterisk,
            ),
            '* Item 1',
          ],
          [
            ListItem(
              'Item 2',
              indicator: UnorderedListItemIndicator.minus,
            ),
            '- Item 2',
          ],
          [
            ListItem(
              'Item 3',
              indicator: UnorderedListItemIndicator.plus,
            ),
            '+ Item 3',
          ],
          [
            ListItem(
              'Item 4',
              indicator: UnorderedListItemIndicator.asterisk,
              children: [
                ListItem(
                  'Item 4.1',
                  indicator: UnorderedListItemIndicator.asterisk,
                ),
                ListItem(
                  'Item 4.2',
                  indicator: UnorderedListItemIndicator.plus,
                ),
              ],
            ),
            '* Item 4\n'
                '  * Item 4.1\n'
                '  + Item 4.2',
          ],
        ],
        (ListItem item, String output) {
          final result = writer.list([item]);
          expect(result, equals(output));
        },
      );

      parameterizedTest(
        'Should write mixed list',
        [
          [
            ListItem(
              'Item 1',
              indicator: OrderedListItemIndicator(),
              children: [
                ListItem(
                  'Item 1.1',
                  indicator: UnorderedListItemIndicator.asterisk,
                ),
                ListItem(
                  'Item 1.2',
                  indicator: OrderedListItemIndicator(),
                ),
              ],
            ),
            '1. Item 1\n'
                '  * Item 1.1\n'
                '  1.2. Item 1.2',
          ],
        ],
        (ListItem item, String output) {
          final result = writer.list([item]);
          expect(result, equals(output));
        },
      );
    },
  );

  parameterizedGroup(
    'MarkdownWriter - Task Lists',
    [DefaultMarkdownWriter()],
    (MarkdownWriter writer) {
      parameterizedTest(
        'should write task list item',
        [
          [
            TaskListItem('Task 1', isChecked: false),
            '* [ ] Task 1',
          ],
          [
            TaskListItem(
              'Task 2',
              indicator: UnorderedListItemIndicator.plus,
              isChecked: false,
            ),
            '+ [ ] Task 2',
          ],
          [
            TaskListItem(
              'Task 3',
              indicator: UnorderedListItemIndicator.minus,
              isChecked: false,
            ),
            '- [ ] Task 3',
          ],
          [
            TaskListItem(
              'Task 4',
              indicator: UnorderedListItemIndicator.plus,
              isChecked: true,
            ),
            '+ [x] Task 4',
          ],
          [
            TaskListItem(
              'Task 5',
              indicator: UnorderedListItemIndicator.asterisk,
              isChecked: false,
              children: [
                TaskListItem('Task 5.1', isChecked: false),
                TaskListItem('Task 5.2', isChecked: true),
              ],
            ),
            '* [ ] Task 5\n'
                '  * [ ] Task 5.1\n'
                '  * [x] Task 5.2',
          ],
        ],
        (TaskListItem item, String output) {
          final result = writer.list([item]);
          expect(result, equals(output));
        },
      );
    },
  );
}
