import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  parameterizedGroup('MarkdownWriter - TextStyles', [
    const [DefaultMarkdownWriter(), 'OneWord'],
    const [DefaultMarkdownWriter(), 'Two Words'],
  ], (MarkdownWriter writer, String word) {
    test('should produce bold text style', () {
      expect(writer.bold(writer.p(word)), equals('**$word**'));
    });

    test('should produce italic text style', () {
      expect(writer.italic(writer.p(word)), equals('*$word*'));
    });

    test('should produce bold+italic text style', () {
      expect(writer.boldItalic(writer.p(word)), equals('***$word***'));
    });

    test('should produce text with a strike through', () {
      expect(writer.strikeThrough(writer.p(word)), equals('~~$word~~'));
    });

    test('should produce highlighted text style', () {
      expect(writer.highlight(writer.p(word)), equals('===$word==='));
    });

    test('should produce paragraph text style', () {
      expect(writer.p(word), equals(word));
    });

    test('should produce coded text style', () {
      expect(writer.coded('print("$word")'), equals('`print("$word")`'));
    });
  });
}
