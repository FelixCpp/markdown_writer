import 'package:markdown_writer/src/term.dart';
import 'package:test/test.dart';

void main() {
  group('Term', () {
    test('Should produce corresponding term syntax', () {
      final term = Term(
        'Term',
        definitions: [
          'Definition 1',
          'Definition 2',
        ],
      );

      expect(
        term.toMarkdown(),
        equals('Term\n: Definition 1\n: Definition 2'),
      );
    });
  });
}
