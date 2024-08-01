import 'package:generator/markdown/list_types/list_type.dart';
import 'package:generator/markdown/list_types/ordered_list_type.dart';
import 'package:generator/markdown/list_types/unordered_list_type.dart';
import 'package:generator/markdown/markdown_writer.dart';
import 'package:generator/markdown/standard_markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(MarkdownWriter, () {
    late MarkdownWriter markdownWriter;

    setUp(() {
      markdownWriter = StandardMarkdownWriter();
    });

    test('should write headline', () {
      expect(markdownWriter.writeH1('Headline'), equals('# Headline'));
      expect(markdownWriter.writeH2('Headline'), equals('## Headline'));
      expect(markdownWriter.writeH3('Headline'), equals('### Headline'));
    });
    test('should write with font styles', () {
      expect(markdownWriter.writeBold('Text'), equals('**Text**'));
      expect(markdownWriter.writeItalic('Text'), equals('*Text*'));
    });
    test('should write url', () {
      expect(
        markdownWriter.writeUrl('Text', Uri.parse('https://example.com')),
        equals('[Text](https://example.com)'),
      );
    });
    test('should write image', () {
      expect(
        markdownWriter.writeImage('Text', Uri.parse('https://example.com')),
        equals('![Text](https://example.com)'),
      );
    });
    test('should write paragraph', () {
      expect(markdownWriter.writeParagraph('Text'), equals('Text'));
    });
    test('should write table', () {
      expect(
          markdownWriter.writeTable(
            ['Head1', 'Head2'],
            [
              ['Row1', 'Row2'],
              ['Row3', 'Row4']
            ],
          ),
          equals('''
| Head1 | Head2 |
| --- | --- |
| Row1 | Row2 |
| Row3 | Row4 |
'''));
    });

    parameterizedTest(
      'should write list with different types',
      [
        {
          'items': ['Item1', 'Item2'],
          'type': OrderedListType(),
          'expected': '1. Item1\n2. Item2\n',
        },
        {
          'items': ['Item1', 'Item2'],
          'type': UnorderedListType(UnorderedListTypeIndicator.minus),
          'expected': '- Item1\n- Item2\n',
        },
        {
          'items': ['Item1', 'Item2'],
          'type': UnorderedListType(UnorderedListTypeIndicator.asterisk),
          'expected': '* Item1\n* Item2\n',
        },
        {
          'items': ['Item1', 'Item2'],
          'type': UnorderedListType(UnorderedListTypeIndicator.plus),
          'expected': '+ Item1\n+ Item2\n',
        },
      ],
      (Map<String, dynamic> data) {
        final items = data['items'] as List<String>;
        final type = data['type'] as ListType;
        final expected = data['expected'] as String;

        expect(markdownWriter.writeList(items, type), equals(expected));
      },
    );
  });
}
