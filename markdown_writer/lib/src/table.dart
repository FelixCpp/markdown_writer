import 'package:markdown_writer/markdown_writer.dart';

final class TableHeader {
  final Markdown header;
  final TableAlignment alignment;

  const TableHeader(this.header, this.alignment);
}

enum TableAlignment {
  none,
  left,
  right,
  center;

  Markdown toMarkdown() {
    return switch (this) {
      TableAlignment.none => '---',
      TableAlignment.left => ':---',
      TableAlignment.right => '---:',
      TableAlignment.center => ':---:',
    };
  }
}
