import 'package:markdown_writer/markdown_writer.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

final class _CodeBlock {
  final CodeFenceStyle style;
  final String? language;
  final String code;
  final String expected;

  _CodeBlock(this.style, this.language, this.code, this.expected);

  @override
  String toString() {
    return 'CodeBlock{style: $style, language: $language, code: $code, expected: $expected}';
  }
}

void main() {
  group('MarkdownWriter - Code', () {
    late MarkdownWriter writer;

    setUp(() {
      writer = DefaultMarkdownWriter();
    });

    parameterizedTest(
      'should produce code block with given language',
      [
        for (final fenceStyle in CodeFenceStyle.values)
          ...() {
            final style = fenceStyle.toMarkdown();
            return [
              _CodeBlock(
                fenceStyle,
                'dart',
                'print("Hello, World!")',
                '${style}dart\nprint("Hello, World!")\n$style',
              ),
              _CodeBlock(
                fenceStyle,
                'python',
                'print("Hello, World!")',
                '${style}python\nprint("Hello, World!")\n$style',
              ),
              _CodeBlock(
                fenceStyle,
                'java',
                'System.out.println("Hello, World!");',
                '${style}java\nSystem.out.println("Hello, World!");\n$style',
              ),
              _CodeBlock(
                fenceStyle,
                'c',
                'printf("Hello, World!");',
                '${style}c\nprintf("Hello, World!");\n$style',
              ),
              _CodeBlock(
                fenceStyle,
                'cpp',
                'std::cout << "Hello, World!" << std::endl;',
                '${style}cpp\nstd::cout << "Hello, World!" << std::endl;\n$style',
              ),
            ];
          }()
      ],
      (_CodeBlock block) {
        final Markdown result = writer.code(
          language: block.language,
          block.code,
          style: block.style,
        );

        expect(result, equals(block.expected));
      },
    );
  });
}
