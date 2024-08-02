import 'package:markdown_writer/markdown_writer.dart';

abstract interface class MarkdownWriter {
  Markdown h1(
    Markdown message, {
    String? id,
    HeadlineSyntax syntax = const HeadlineSyntax.core(level: 1),
  });
  Markdown h2(
    Markdown message, {
    String? id,
    HeadlineSyntax syntax = const HeadlineSyntax.core(level: 2),
  });
  Markdown h3(Markdown message, {String? id});
  Markdown h4(Markdown message, {String? id});
  Markdown h5(Markdown message, {String? id});
  Markdown h6(Markdown message, {String? id});

  Markdown p(String message);
  Markdown bold(Markdown message);
  Markdown italic(Markdown message);
  Markdown boldItalic(Markdown message);
  Markdown highlight(Markdown message);
  Markdown strikeThrough(Markdown message);

  Markdown coded(Markdown message);
  Markdown code(
    String message, {
    String? language,
    CodeFenceStyle style = CodeFenceStyle.tripleBackticks,
  });

  Markdown blockQuote(Iterable<Markdown> lines);
  Markdown horizontalRule([
    HorizontalRuleStyle style = HorizontalRuleStyle.asterisk,
    int count = 3,
  ]);
  Markdown admonition(String type);
  Markdown alert(MarkdownAlertType type, Iterable<Markdown> lines);
  Markdown comment(String commentName, String message);

  Markdown link(MarkdownTextLink link, [Markdown? message]);
  Markdown image(MarkdownImageLink link, [String? message]);

  Markdown table(
    List<TableHeader> headers,
    List<List<Markdown>> rows,
  );

  Markdown list(List<ListItem> items);
}
