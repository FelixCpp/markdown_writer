import 'package:markdown_writer/markdown_writer.dart';

extension on String? {
  String inject() => this != null ? ' {#$this}' : '';
}

final class DefaultMarkdownWriter implements MarkdownWriter {
  const DefaultMarkdownWriter();

  /// Headlines

  @override
  Markdown h1(
    Markdown message, {
    String? id,
    HeadlineSyntax syntax = HeadlineSyntax.core,
  }) =>
      switch (syntax) {
        HeadlineSyntax.core => '# $message${id.inject()}',
        HeadlineSyntax.alternative => '$message${id.inject()}\n=',
      };

  @override
  Markdown h2(
    Markdown message, {
    String? id,
    HeadlineSyntax syntax = HeadlineSyntax.core,
  }) =>
      switch (syntax) {
        HeadlineSyntax.core => '## $message${id.inject()}',
        HeadlineSyntax.alternative => '$message${id.inject()}\n-',
      };
  @override
  Markdown h3(Markdown message, {String? id}) => '### $message${id.inject()}';
  @override
  Markdown h4(Markdown message, {String? id}) => '#### $message${id.inject()}';
  @override
  Markdown h5(Markdown message, {String? id}) => '##### $message${id.inject()}';
  @override
  Markdown h6(Markdown message, {String? id}) =>
      '###### $message${id.inject()}';

  /// Text

  @override
  Markdown p(String message) => message;
  @override
  Markdown bold(Markdown message) => '**$message**';
  @override
  Markdown italic(Markdown message) => '*$message*';
  @override
  Markdown boldItalic(Markdown message) => '***$message***';
  @override
  Markdown highlight(Markdown message) => '===$message===';
  @override
  Markdown strikeThrough(Markdown message) => '~~$message~~';

  /// Code

  @override
  Markdown coded(Markdown message) => '`$message`';
  @override
  Markdown code(
    String message, {
    String? language,
    CodeFenceStyle style = CodeFenceStyle.tripleBackticks,
  }) {
    return '${style.toMarkdown()}${language ?? ''}\n$message\n${style.toMarkdown()}';
  }

  /// Styling

  @override
  Markdown blockQuote(Iterable<Markdown> lines) =>
      lines.map((line) => '> $line').join('\n');

  @override
  Markdown horizontalRule([
    HorizontalRuleStyle style = HorizontalRuleStyle.asterisks,
  ]) {
    return style.toMarkdown();
  }

  @override
  Markdown admonition(String type) => ':$type:';

  @override
  Markdown alert(MarkdownAlertType type, Iterable<Markdown> lines) {
    return blockQuote([
      type.toMarkdown(),
      ...lines,
    ]);
  }

  @override
  Markdown comment(String commentName, String message) {
    assert(commentName.isNotEmpty, 'Comment name must not be empty');
    return '[$commentName]: $message';
  }

  /// Links

  @override
  Markdown link(MarkdownTextLink link, [Markdown? message]) {
    return link.toMarkdown(message ?? link.link);
  }

  @override
  Markdown image(MarkdownImageLink link, [String? alternativeText]) {
    return link.toMarkdown(alternativeText ?? link.link);
  }

  /// Complex structures

  @override
  Markdown table(List<TableHeader> headers, List<List<Markdown>> rows) {
    final buffer = StringBuffer();

    buffer.writeln('| ${headers.map((column) => column.header).join(' | ')} |');
    buffer.writeln(
        '| ${headers.map((column) => column.alignment.toMarkdown()).join(' | ')} |');
    buffer.writeln(rows.map((row) => '| ${row.join(' | ')} |').join('\n'));

    return buffer.toString();
  }

  @override
  Markdown list(List<ListItem> items) {
    final result = <Markdown>[];

    for (final (index, item) in items.indexed) {
      result.add(item.toMarkdown(index));
    }

    return result.join('\n');
  }

  @override
  Markdown taskList(List<TaskListItem> items) {
    final result = <Markdown>[];

    for (final (index, item) in items.indexed) {
      result.add(item.toMarkdown(index));
    }

    return result.join('\n');
  }
}
