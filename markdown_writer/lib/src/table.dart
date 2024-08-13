import 'package:markdown_writer/markdown_writer.dart';

enum TableHeaderAlignment implements MarkdownEntry {
  none,
  left,
  right,
  center;

  @override
  Markdown toMarkdown() {
    return switch (this) {
      TableHeaderAlignment.none => '---',
      TableHeaderAlignment.left => ':---',
      TableHeaderAlignment.right => '---:',
      TableHeaderAlignment.center => ':---:'
    };
  }
}

final class TableHeader {
  final Markdown text;
  final TableHeaderAlignment alignment;

  const TableHeader({
    required this.text,
    required this.alignment,
  });
}

final class MarkdownTable implements MarkdownEntry {
  final List<TableHeader> headers;
  final List<List<Markdown>> rows;

  MarkdownTable({
    required this.headers,
    required this.rows,
  }) {
    assert(() {
      return rows.every((row) => row.length == headers.length);
    }(), "");
  }

  @override
  Markdown toMarkdown() {
    final headlineRow =
        '| ${headers.map((header) => header.text).join(' | ')} |';
    final alignmentRow =
        '| ${headers.map((header) => header.alignment.toMarkdown()).join(' | ')} |';
    final rows = this.rows.map((row) => '| ${row.join(' | ')} |').join('\n');
    return '$headlineRow\n$alignmentRow\n$rows';
  }
}
