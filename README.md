# markdown_generator

This library provides an API to write markdown files in code.
I started this project in order to generate dependencies.md files for various projects.
Later on the writer got a little too complex for such a simple library so i decided to extract him into it's own library.

## Basic usage example:

```dart
void saveToFile(File file) {
    final MarkdownWriter writer = DefaultMarkdownWriter();
    final Markdown table = writer.table(
    [
        MarkdownHeader(writer.p('Name'), MarkdownTableAlignment.left),
        MarkdownHeader(writer.p('Version'), MarkdownTableAlignment.right),
    ],
    [
        ['Dart', '2.14.4'],
        ['Flutter', '2.5.3'],
    ]);

    file.writeAsStringSync(table);
}
```