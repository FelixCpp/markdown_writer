import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('MarkdownWriter - Link', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    parameterizedTest(
      'should produce link with given text and url',
      [
        [
          MarkdownTextLink('https://www.google.com', tooltip: 'Google'),
          'Click Me',
          '[Click Me](https://www.google.com "Google")'
        ],
        [
          MarkdownTextLink('https://www.flutter.com', tooltip: 'Flutter'),
          'Click Me',
          '[Click Me](https://www.flutter.com "Flutter")'
        ],
        [
          MarkdownTextLink('https://www.github.com', tooltip: 'GitHub'),
          null,
          '[https://www.github.com](https://www.github.com "GitHub")'
        ],
        [
          MarkdownTextLink('https://www.netflix.com', tooltip: null),
          'Netflix',
          '[Netflix](https://www.netflix.com)'
        ]
      ],
      (MarkdownTextLink link, String? text, String expected) {
        final Markdown result = writer.link(link, text);
        expect(result, equals(expected));
      },
    );

    parameterizedTest(
      'should produce image link with given parameters',
      [
        [
          MarkdownImageLink(
            'https://www.google.com/image.png',
            tooltip: 'Google',
          ),
          'Click Me',
          '![Click Me](https://www.google.com/image.png "Google")'
        ],
        [
          MarkdownImageLink(
            'https://www.flutter.com/image.png',
            tooltip: 'Flutter',
          ),
          'Click Me',
          '![Click Me](https://www.flutter.com/image.png "Flutter")'
        ],
        [
          MarkdownImageLink(
            'https://www.github.com/image.png',
            tooltip: 'GitHub',
          ),
          null,
          '![https://www.github.com/image.png](https://www.github.com/image.png "GitHub")'
        ],
        [
          MarkdownImageLink('https://www.netflix.com/image.png', tooltip: null),
          'Netflix',
          '![Netflix](https://www.netflix.com/image.png)'
        ]
      ],
      (MarkdownImageLink link, String? text, String expected) {
        final Markdown result = writer.image(link, text);
        expect(result, equals(expected));
      },
    );
  });
}
