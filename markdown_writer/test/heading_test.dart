import 'package:markdown_writer/src/heading.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('CoreSyntaxHeading', () {
    parameterizedTest(
      'Should produce corresponding heading syntax',
      [
        [CoreHeadingSyntax.h1(), '# Heading'],
        [CoreHeadingSyntax.h2(), '## Heading'],
        [CoreHeadingSyntax.h3(), '### Heading'],
        [CoreHeadingSyntax.h4(), '#### Heading'],
        [CoreHeadingSyntax.h5(), '##### Heading'],
        [CoreHeadingSyntax.h6(), '###### Heading'],
        [CoreHeadingSyntax(1), '# Heading'],
        [CoreHeadingSyntax(2), '## Heading'],
        [CoreHeadingSyntax(3), '### Heading'],
        [CoreHeadingSyntax(4), '#### Heading'],
        [CoreHeadingSyntax(5), '##### Heading'],
        [CoreHeadingSyntax(6), '###### Heading'],
        [CoreHeadingSyntax.h1(id: 'My-Custom-Id'), '# Heading {#My-Custom-Id}'],
      ],
      (HeadingSyntax level, String expectedSyntax) {
        final formatted = level.format('Heading');
        expect(formatted, equals(expectedSyntax));
      },
    );
  });

  group('AlternateSyntaxHeading', () {
    parameterizedTest(
      'Should produce corresponding heading syntax',
      [
        [AlternateHeadingSyntax('*'), 'Heading\n*******'],
        [AlternateHeadingSyntax('-'), 'Heading\n-------'],
        [AlternateHeadingSyntax('_'), 'Heading\n_______'],
        [AlternateHeadingSyntax('*', length: 3), 'Heading\n***'],
        [AlternateHeadingSyntax('-', length: 3), 'Heading\n---'],
        [AlternateHeadingSyntax('_', length: 3), 'Heading\n___'],
        [
          AlternateHeadingSyntax('_', length: 3, id: 'My-Custom-Id'),
          'Heading {#My-Custom-Id}\n___'
        ],
      ],
      (HeadingSyntax syntax, String expectedSyntax) {
        final formatted = syntax.format('Heading');
        expect(formatted, equals(expectedSyntax));
      },
    );
  });

  group('Heading', () {
    parameterizedTest(
      'Should produce corresponding heading syntax',
      [
        [Heading(syntax: CoreHeadingSyntax.h1(), text: 'Heading'), '# Heading'],
        [
          Heading(syntax: CoreHeadingSyntax.h2(), text: 'Heading'),
          '## Heading'
        ],
        [
          Heading(syntax: CoreHeadingSyntax.h3(), text: 'Heading'),
          '### Heading'
        ],
        [
          Heading(syntax: CoreHeadingSyntax.h4(), text: 'Heading'),
          '#### Heading'
        ],
        [
          Heading(syntax: CoreHeadingSyntax.h5(), text: 'Heading'),
          '##### Heading'
        ],
        [
          Heading(syntax: CoreHeadingSyntax.h6(), text: 'Heading'),
          '###### Heading'
        ],
        [
          Heading(syntax: AlternateHeadingSyntax('*'), text: 'Heading'),
          'Heading\n*******'
        ],
        [
          Heading(syntax: AlternateHeadingSyntax('-'), text: 'Heading'),
          'Heading\n-------'
        ],
        [
          Heading(syntax: AlternateHeadingSyntax('_'), text: 'Heading'),
          'Heading\n_______'
        ],
        [
          Heading(
              syntax: AlternateHeadingSyntax('*', length: 3), text: 'Heading'),
          'Heading\n***'
        ],
        [
          Heading(
              syntax: AlternateHeadingSyntax('-', length: 3), text: 'Heading'),
          'Heading\n---'
        ],
        [
          Heading(
              syntax: AlternateHeadingSyntax('_', length: 3), text: 'Heading'),
          'Heading\n___'
        ],
      ],
      (Heading heading, String expectedSyntax) {
        final formatted = heading.toMarkdown();
        expect(formatted, equals(expectedSyntax));
      },
    );
  });
}
