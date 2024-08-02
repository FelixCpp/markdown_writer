import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('MarkdownWriter - Headlines', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    test(
      'write h1',
      () {
        expect(writer.h1(writer.p('Hello')), equals('# Hello'));
        expect(writer.h1(writer.p('Hello'), syntax: HeadlineSyntax.alternative),
            equals('Hello\n='));
        expect(writer.h1(writer.p('Hello'), id: 'H1'), equals('# Hello {#H1}'));
      },
    );
    test(
      'write h2',
      () {
        expect(writer.h2(writer.p('Hello')), equals('## Hello'));
        expect(
            writer.h2(writer.p('Hello'), id: 'H2'), equals('## Hello {#H2}'));

        expect(writer.h2(writer.p('Hello'), syntax: HeadlineSyntax.alternative),
            equals('Hello\n-'));
        expect(
            writer.h2(writer.p('Hello'), id: 'H2'), equals('## Hello {#H2}'));
      },
    );
    test('write h3', () {
      expect(writer.h3(writer.p('Hello')), equals('### Hello'));
      expect(writer.h3(writer.p('Hello'), id: 'H3'), equals('### Hello {#H3}'));
    });
    test('write h4', () {
      expect(writer.h4(writer.p('Hello')), equals('#### Hello'));
      expect(
          writer.h4(writer.p('Hello'), id: 'H4'), equals('#### Hello {#H4}'));
    });
    test('write h5', () {
      expect(writer.h5(writer.p('Hello')), equals('##### Hello'));
      expect(
          writer.h5(writer.p('Hello'), id: 'H5'), equals('##### Hello {#H5}'));
    });
    test('write h6', () {
      expect(writer.h6(writer.p('Hello')), equals('###### Hello'));
      expect(
          writer.h6(writer.p('Hello'), id: 'H6'), equals('###### Hello {#H6}'));
    });
  });

  group('MarkdownWriter - Text', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    test(
      'write paragraph',
      () => expect(writer.p('Hello'), equals('Hello')),
    );
    test(
      'write bold',
      () => expect(writer.bold(writer.p('Hello')), equals('**Hello**')),
    );
    test(
      'write italic',
      () => expect(
        writer.italic(writer.p('Hello')),
        equals('*Hello*'),
      ),
    );

    test(
      'write bold italic',
      () => expect(
        writer.boldItalic(writer.p('Hello')),
        equals('***Hello***'),
      ),
    );

    test('write code', () {
      final result = writer.code(language: 'dart', 'print("Hello")');
      expect(result, equals('```dart\nprint("Hello")\n```'));
    });

    test('write code with tilde', () {
      final result = writer.code(
        'print("Hello")',
        style: CodeFenceStyle.tilde,
      );
      expect(result, equals('~~~\nprint("Hello")\n~~~'));
    });
  });

  group('MarkdownWriter - BlockQuotes', () {
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

  group('MarkdownWriter - TextLink', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    test(
      'write link',
      () => expect(
        writer.link(
          MarkdownTextLink('https://example.com'),
          writer.p('Example'),
        ),
        equals('[Example](https://example.com)'),
      ),
    );

    test(
      'write link with tooltip',
      () => expect(
        writer.link(
          MarkdownTextLink('https://example.com', tooltip: 'Tooltip'),
          writer.p('Example'),
        ),
        equals('[Example](https://example.com "Tooltip")'),
      ),
    );

    test(
      'write link with code',
      () => expect(
        writer.link(
          MarkdownTextLink('https://example.com'),
          writer.coded(writer.p('Example')),
        ),
        equals('[`Example`](https://example.com)'),
      ),
    );
  });

  group('MarkdownWriter - Image', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    test(
      'write image',
      () => expect(
        writer.image(
          MarkdownImageLink('https://example.com/image.png'),
          'Example',
        ),
        equals('![Example](https://example.com/image.png)'),
      ),
    );

    test(
      'write image with tooltip',
      () => expect(
        writer.image(
          MarkdownImageLink(
            'https://example.com/image.png',
            tooltip: 'Tooltip',
          ),
          'Example',
        ),
        equals('![Example](https://example.com/image.png "Tooltip")'),
      ),
    );
  });

  group('MarkdownWriter - Rules', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    parameterizedTest(
      'write horizontal rule',
      const [
        [HorizontalRuleStyle.asterisks, '***'],
        [HorizontalRuleStyle.dashes, '---'],
        [HorizontalRuleStyle.underscores, '___'],
      ],
      (HorizontalRuleStyle style, String expected) {
        final result = writer.horizontalRule(style);
        expect(result, equals(expected));
      },
    );
  });

  group('MarkdownWriter - Tables', () {
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

  group('MarkdownWriter - Lists', () {
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
