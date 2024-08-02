import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  parameterizedGroup(
    'MarkdownWriter - Tables',
    [DefaultMarkdownWriter()],
    (MarkdownWriter writer) {
      parameterizedTest('write table', const [
        [
          [
            TableHeader('Name', TableAlignment.left),
            TableHeader('Version', TableAlignment.right),
            TableHeader('Type', TableAlignment.none),
          ],
          [
            ['Dart', '2.14.0', 'SDK'],
            ['Flutter', '2.5.0', 'Framework'],
          ],
          '| Name | Version | Type |\n'
              '| :--- | ---: | --- |\n'
              '| Dart | 2.14.0 | SDK |\n'
              '| Flutter | 2.5.0 | Framework |\n',
        ],
        [
          [
            TableHeader('Name', TableAlignment.left),
            TableHeader('Version', TableAlignment.right),
            TableHeader('Type', TableAlignment.center),
          ],
          [
            ['Dart', '2.14.4', 'SDK'],
            ['Flutter', '2.5.3', 'Framework'],
            ['AngularDart', '5.0.0', 'Framework'],
          ],
          '| Name | Version | Type |\n'
              '| :--- | ---: | :---: |\n'
              '| Dart | 2.14.4 | SDK |\n'
              '| Flutter | 2.5.3 | Framework |\n'
              '| AngularDart | 5.0.0 | Framework |\n',
        ],
      ], (List<TableHeader> headers, List<List<String>> rows, String output) {
        final result = writer.table(headers, rows);
        expect(result, equals(output));
      });
    },
  );
}
