import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  parameterizedGroup('MarkdownWriter - Headlines', [
    const [DefaultMarkdownWriter(), 'OneWord'],
    const [DefaultMarkdownWriter(), 'Two Words'],
  ], (MarkdownWriter writer, String word) {
    parameterizedTest(
      'should generate expected output with given inputs',
      [
        [const HeadlineSyntax.core(level: 1), null, '# $word'],
        [const HeadlineSyntax.alternative(repetitions: 1), null, '$word\n='],
        [const HeadlineSyntax.core(level: 1), 'H1', '# $word {#H1}'],
        [
          const HeadlineSyntax.alternative(repetitions: 1),
          'H1',
          '$word {#H1}\n='
        ],
      ],
      (HeadlineSyntax syntax, String? id, String expected) {
        final Markdown result = writer.h1(word, syntax: syntax, id: id);
        expect(result, equals(expected));
      },
    );
  });
}
