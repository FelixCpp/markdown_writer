import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('MarkdownWriter - HorizontalRule', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    parameterizedTest(
      'should generate expected output with given inputs',
      [
        [HorizontalRuleStyle.dash, 3, '---'],
        [HorizontalRuleStyle.asterisk, 5, '*****'],
        [HorizontalRuleStyle.underscore, 7, '_______'],
      ],
      (HorizontalRuleStyle style, int count, String expected) {
        final result = writer.horizontalRule(style, count);
        expect(result, equals(expected));
      },
    );
  });
}
