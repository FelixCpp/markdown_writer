import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  parameterizedGroup(
    'MarkdownWriter - Comments',
    [DefaultMarkdownWriter()],
    (MarkdownWriter writer) {
      parameterizedTest('should generate expected output with given inputs', [
        ['Comment 1', 'This is comment 1'],
        ['Comment 2', 'This is comment 2'],
        ['Comment 3', 'This is comment 3'],
      ], (String name, String comment) {
        expect(writer.comment(name, comment), equals('[$name]: $comment'));
      });
    },
  );
}
