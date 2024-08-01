import 'package:generator/markdown/list_types/list_type.dart';
import 'package:generator/markdown/markdown.dart';
import 'package:generator/markdown/markdown_writer.dart';

final class StandardMarkdownWriter implements MarkdownWriter {
  @override
  Markdown writeBold(String text) => Markdown('**$text**');

  @override
  Markdown writeH1(String text) => Markdown('# $text');

  @override
  Markdown writeH2(String text) => Markdown('## $text');

  @override
  Markdown writeH3(String text) => Markdown('### $text');

  @override
  Markdown writeImage(String text, Uri url) => Markdown('![$text]($url)');

  @override
  Markdown writeItalic(String text) => Markdown('*$text*');

  @override
  Markdown writeList(List<String> items, ListType type) {
    final buffer = StringBuffer();

    for (final (i, item) in items.indexed) {
      buffer.writeln('${type.getValue(i + 1)} $item');
    }

    return Markdown(buffer.toString());
  }

  @override
  Markdown writeParagraph(String text) => Markdown(text);

  @override
  Markdown writeTable(List<String> headlines, List<List<String>> rows) {
    final buffer = StringBuffer();

    buffer.writeln('| ${headlines.join(' | ')} |');
    buffer.writeln('| ${List.filled(headlines.length, '---').join(' | ')} |');

    for (final row in rows) {
      buffer.writeln('| ${row.join(' | ')} |');
    }

    return Markdown(buffer.toString());
  }

  @override
  Markdown writeUrl(String text, Uri url) => Markdown('[$text]($url)');
}
