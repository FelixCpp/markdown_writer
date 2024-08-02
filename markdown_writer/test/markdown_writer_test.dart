import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(skip: true, 'MarkdownWriter - BlockQuotes', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    test('write block quote', () {
      final result = writer.blockQuote([writer.p('Hello')]);
      expect(result, equals('> Hello'));
    });

    test('write multiple block quotes', () {
      final quote = writer.blockQuote([writer.p('Hello')]);
      final result = writer.blockQuote([quote]);
      expect(result, equals('> > Hello'));
    });
  });

  group(skip: true, 'MarkdownWriter - Rules', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    parameterizedTest(
      'write horizontal rule',
      const [
        [HorizontalRuleStyle.asterisk, '***'],
        [HorizontalRuleStyle.dash, '---'],
        [HorizontalRuleStyle.underscore, '___'],
      ],
      (HorizontalRuleStyle style, String expected) {
        final result = writer.horizontalRule(style);
        expect(result, equals(expected));
      },
    );
  });

  group(skip: true, 'MarkdownWriter - Tables', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    test(
      'write table',
      () => expect(
        writer.table(
          [
            TableHeader(writer.p('Name'), TableAlignment.left),
            TableHeader(writer.p('Version'), TableAlignment.right),
          ],
          [
            ['Dart', '2.14.4'],
            ['Flutter', '2.5.3'],
          ],
        ),
        equals(
          '| Name | Version |\n'
          '| :--- | ---: |\n'
          '| Dart | 2.14.4 |\n'
          '| Flutter | 2.5.3 |\n',
        ),
      ),
    );

    test(
      'write table with center alignment',
      () => expect(
        writer.table(
          [
            TableHeader(writer.p('Name'), TableAlignment.center),
            TableHeader(writer.p('Version'), TableAlignment.center),
          ],
          [
            ['Dart', '2.14.4'],
            ['Flutter', '2.5.3'],
          ],
        ),
        equals(
          '| Name | Version |\n'
          '| :---: | :---: |\n'
          '| Dart | 2.14.4 |\n'
          '| Flutter | 2.5.3 |\n',
        ),
      ),
    );

    test(
      'write table with no alignment',
      () => expect(
        writer.table(
          [
            TableHeader(writer.p('Name'), TableAlignment.none),
            TableHeader(writer.p('Version'), TableAlignment.none),
          ],
          [
            ['Dart', '2.14.4'],
            ['Flutter', '2.5.3'],
          ],
        ),
        equals(
          '| Name | Version |\n'
          '| --- | --- |\n'
          '| Dart | 2.14.4 |\n'
          '| Flutter | 2.5.3 |\n',
        ),
      ),
    );
  });

  group(skip: true, 'MarkdownWriter - Lists', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    test(
      'write list',
      () => expect(
        writer.list([
          ListItem(writer.p('Hello')),
          ListItem(writer.p('World')),
        ]),
        equals('- Hello\n- World'),
      ),
    );

    test(
      'write task list',
      () => expect(
        writer.taskList([
          TaskListItem(writer.p('Hello'), isChecked: true),
          TaskListItem(writer.p('World'), isChecked: false),
        ]),
        equals('* [x] Hello\n* [ ] World'),
      ),
    );

    test(
      'write task list with custom bullet',
      () => expect(
        writer.taskList([
          TaskListItem(
            writer.p('Hello'),
            indicator: OrderedListItemIndicator(),
            isChecked: true,
          ),
          TaskListItem(
            writer.p('World'),
            indicator: UnorderedListItemIndicator.minus,
            isChecked: false,
          ),
        ]),
        equals('1. [x] Hello\n- [ ] World'),
      ),
    );
  });
}
