import 'package:markdown_writer/markdown_writer.dart';
import 'package:test/test.dart';

void main() {
  group('Table', () {
    test('should render a table with headers and rows', () {
      final table = MarkdownTable(
        headers: [
          TableHeader(text: 'Header 1', alignment: TableHeaderAlignment.center),
          TableHeader(text: 'Header 2', alignment: TableHeaderAlignment.right),
          TableHeader(text: 'Header 3', alignment: TableHeaderAlignment.left),
        ],
        rows: [
          ['Row 1, Cell 1', 'Row 1, Cell 2', 'Row 1, Cell 3'],
          ['Row 2, Cell 1', 'Row 2, Cell 2', 'Row 2, Cell 3'],
        ],
      );

      expect(
        table.toMarkdown().toString(),
        equals(
          '| Header 1 | Header 2 | Header 3 |\n'
          '| :---: | ---: | :--- |\n'
          '| Row 1, Cell 1 | Row 1, Cell 2 | Row 1, Cell 3 |\n'
          '| Row 2, Cell 1 | Row 2, Cell 2 | Row 2, Cell 3 |',
        ),
      );
    });

    test(
      'should throw an assertion error if the rows have different lengths',
      () {
        expect(
          () => MarkdownTable(
            headers: [
              TableHeader(
                text: 'Header 1',
                alignment: TableHeaderAlignment.center,
              ),
              TableHeader(
                text: 'Header 2',
                alignment: TableHeaderAlignment.right,
              ),
              TableHeader(
                text: 'Header 3',
                alignment: TableHeaderAlignment.left,
              ),
            ],
            rows: [
              ['Row 1, Cell 1', 'Row 1, Cell 2'],
              ['Row 2, Cell 1', 'Row 2, Cell 2', 'Row 2, Cell 3'],
            ],
          ),
          throwsA(isA<AssertionError>()),
        );
      },
    );
  });
}
