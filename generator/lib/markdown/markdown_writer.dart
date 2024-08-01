import 'package:generator/markdown/list_types/list_type.dart';
import 'package:generator/markdown/markdown.dart';

abstract interface class MarkdownWriter {
  Markdown writeH1(String text);
  Markdown writeH2(String text);
  Markdown writeH3(String text);

  Markdown writeBold(String text);
  Markdown writeItalic(String text);

  Markdown writeParagraph(String text);

  Markdown writeUrl(String text, Uri url);
  Markdown writeImage(String text, Uri url);

  Markdown writeTable(List<String> headlines, List<List<String>> rows);
  Markdown writeList(List<String> items, ListType type);
}
