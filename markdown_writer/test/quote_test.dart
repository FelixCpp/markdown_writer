import 'package:markdown_writer/src/quote.dart';
import 'package:test/test.dart';

void main() {
  group('Quote', () {
    test('Should produce a single quote', () {
      final quote = Quote('This is a quote');
      expect(quote.toMarkdown(), equals('> This is a quote'));
    });

    test('Should produce a double quote', () {
      final quote = Quote('This is a quote', indentation: 2);
      expect(quote.toMarkdown(), equals('>> This is a quote'));
    });
  });
}
