import 'package:markdown_writer/markdown_writer.dart';
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
}
