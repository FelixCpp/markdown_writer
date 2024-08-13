import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('Bold', () {
    parameterizedTest(
      'Should produce corresponding bold syntax',
      [
        const [Stylized.bold('Bold'), '**Bold**'],
        const [Stylized.italic('Italic'), '*Italic*'],
        const [Stylized.boldItalic('BoldItalic'), '***BoldItalic***'],
        const [Stylized.bold('Bold', StyleType.underscore), '__Bold__'],
        const [Stylized.italic('Italic', StyleType.underscore), '_Italic_'],
        const [
          Stylized.boldItalic('BoldItalic', StyleType.underscore),
          '___BoldItalic___'
        ],
        const [Stylized.strikeThrough('StrikeThrough'), '~~StrikeThrough~~'],
        const [Stylized.code('Code'), '`Code`'],
        [
          Stylized.link(text: 'Link', url: Uri.parse('https://example.com')),
          '[Link](https://example.com)'
        ],
        [
          Stylized.link(
            text: 'Link',
            url: Uri.parse('https://example.com'),
            tooltip: 'Tooltip',
          ),
          '[Link "Tooltip"](https://example.com)'
        ],
        [
          Stylized.link(
            text: 'Link',
            url: Uri.parse('https://example.com'),
            tooltip: '',
          ),
          '[Link](https://example.com)'
        ],
        [
          Stylized.image(text: 'Image', url: Uri.parse('https://example.com')),
          '![Image](https://example.com)'
        ],
        [
          Stylized.image(
            text: 'Image',
            url: Uri.parse('https://example.com'),
            tooltip: '',
          ),
          '![Image](https://example.com)'
        ],
        [
          Stylized.image(
            text: 'Image',
            url: Uri.parse('https://example.com'),
            tooltip: 'Tooltip',
          ),
          '![Image "Tooltip"](https://example.com)'
        ],
        [Stylized.highlighted('Highlighted'), '==Highlighted=='],
        [Stylized.subscribt('Subscribt'), '~Subscribt~'],
        [Stylized.superscribt('Superscribt'), '^Superscribt^'],
        [
          Stylized.codeblock('print("Hello, Wordl!");', language: 'dart'),
          '```dart\nprint("Hello, Wordl!");\n```'
        ],
      ],
      (Stylized bold, String expectedSyntax) {
        expect(bold.toMarkdown(), equals(expectedSyntax));
      },
    );
  });
}
