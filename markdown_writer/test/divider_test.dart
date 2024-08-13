import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('Divider Test', () {
    parameterizedTest(
      'Should produce corresponding character for specified syntax',
      [
        const [DividerSyntax.hyphens, '-'],
        const [DividerSyntax.asterisks, '*'],
        const [DividerSyntax.underscores, '_'],
      ],
      (MarkdownEntry syntax, Markdown expectedGlyph) {
        expect(syntax.toMarkdown(), equals(expectedGlyph));
      },
    );
  });
}
