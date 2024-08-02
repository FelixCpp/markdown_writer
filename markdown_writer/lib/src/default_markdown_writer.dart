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
      }
          .toMarkdown();

  @override
  Markdown h2(
    Markdown message, {
    String? id,
    HeadlineSyntax syntax = HeadlineSyntax.core,
  }) =>
      switch (syntax) {
        HeadlineSyntax.core => '## $message${id.inject()}',
        HeadlineSyntax.alternative => '$message${id.inject()}\n-',
      }
          .toMarkdown();
  @override
  Markdown h3(Markdown message, {String? id}) =>
      '### $message${id.inject()}'.toMarkdown();
  @override
  Markdown h4(Markdown message, {String? id}) =>
      '#### $message${id.inject()}'.toMarkdown();
  @override
  Markdown h5(Markdown message, {String? id}) =>
      '##### $message${id.inject()}'.toMarkdown();
  @override
  Markdown h6(Markdown message, {String? id}) =>
      '###### $message${id.inject()}'.toMarkdown();

  /// Text

  @override
  Markdown p(String message) => message.toMarkdown();
  @override
  Markdown bold(Markdown message) => '**$message**'.toMarkdown();
  @override
  Markdown italic(Markdown message) => '*$message*'.toMarkdown();
  @override
  Markdown boldItalic(Markdown message) => '***$message***'.toMarkdown();
  @override
  Markdown highlight(Markdown message) => '===$message==='.toMarkdown();
  @override
  Markdown strikeThrough(Markdown message) => '~~$message~~'.toMarkdown();

  /// Code

  @override
  Markdown coded(Markdown message) => '`$message`'.toMarkdown();
  @override
  Markdown code(
    String message, {
    String? language,
    CodeFenceStyle style = CodeFenceStyle.tripleBackticks,
  }) {
    return '${style.toMarkdown()}${language ?? ''}\n$message\n${style.toMarkdown()}'
        .toMarkdown();
  }

  /// Styling

  @override
  Markdown blockQuote(Iterable<Markdown> lines) =>
      lines.map((line) => '> $line').join('\n').toMarkdown();

  @override
  Markdown horizontalRule(HorizontalRuleStyle style) {
    return switch (style) {
      HorizontalRuleStyle.asterisks => '***',
      HorizontalRuleStyle.dashes => '---',
      HorizontalRuleStyle.underscores => '___',
    }
        .toMarkdown();
  }

  @override
  Markdown admonition(String type) => ':$type:'.toMarkdown();

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
    return '[$commentName]: $message'.toMarkdown();
  }

  /// Links

  @override
  Markdown link(MarkdownTextLink link, [Markdown? message]) {
    return link.toMarkdown(message ?? link.link.toMarkdown());
  }

  @override
  Markdown image(MarkdownImageLink link, [String? alternativeText]) {
    return link.toMarkdown(alternativeText ?? link.link);
  }

  /// Complex structures

  @override
  Markdown table(List<MarkdownHeader> headers, List<List<String>> rows) {
    final buffer = StringBuffer();

    buffer.writeln('| ${headers.map((column) => column.header).join(' | ')} |');
    buffer.writeln(
        '| ${headers.map((column) => column.alignment.toMarkdown()).join(' | ')} |');
    buffer.writeln(rows.map((row) => '| ${row.join(' | ')} |').join('\n'));

    return buffer.toString().toMarkdown();
  }

  @override
  Markdown list(List<ListItem> items) {
    final buffer = StringBuffer();

    for (final (index, item) in items.indexed) {
      final indentation = '  ' * item.indentation;
      final indicator = item.indicator.toMarkdown(index);
      final message = item.message;

      buffer.writeln('$indentation$indicator $message');
    }

    return buffer.toString().toMarkdown();
  }

  @override
  Markdown taskList(List<TaskListItem> items) {
    final buffer = StringBuffer();

    for (final (index, item) in items.indexed) {
      final indentation = '  ' * item.indentation;
      final indicator = item.indicator.toMarkdown(index);
      final message = item.message;
      final isChecked = item.isChecked ? 'x' : ' ';

      buffer.writeln('$indentation$indicator [$isChecked] $message');
    }

    return buffer.toString().toMarkdown();
  }
}
