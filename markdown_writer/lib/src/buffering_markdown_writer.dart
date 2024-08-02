import 'package:markdown_writer/markdown_writer.dart';

final class BufferingMarkdownWriter implements MarkdownWriter {
  final StringBuffer _buffer = StringBuffer();
  final MarkdownWriter _writer;

  BufferingMarkdownWriter(this._writer);

  Markdown get content => _buffer.toString();

  void insert(Markdown markdown) {
    _buffer.writeln(markdown);
  }

  /// Headlines

  @override
  Markdown h1(
    Markdown message, {
    String? id,
    HeadlineSyntax syntax = HeadlineSyntax.core,
  }) {
    final result = _writer.h1(message, syntax: syntax, id: id);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown h2(
    Markdown message, {
    String? id,
    HeadlineSyntax syntax = HeadlineSyntax.core,
  }) {
    final result = _writer.h2(message, id: id, syntax: syntax);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown h3(Markdown message, {String? id}) {
    final result = _writer.h3(message, id: id);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown h4(Markdown message, {String? id}) {
    final result = _writer.h4(message, id: id);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown h5(Markdown message, {String? id}) {
    final result = _writer.h5(message, id: id);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown h6(Markdown message, {String? id}) {
    final result = _writer.h6(message, id: id);
    _buffer.writeln(result);
    return result;
  }

  /// Text

  @override
  Markdown p(String message) {
    final result = _writer.p(message);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown bold(Markdown message) {
    final result = _writer.bold(message);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown italic(Markdown message) {
    final result = _writer.italic(message);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown boldItalic(Markdown message) {
    final result = _writer.boldItalic(message);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown highlight(Markdown message) {
    final result = _writer.highlight(message);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown strikeThrough(Markdown message) {
    final result = _writer.strikeThrough(message);
    _buffer.writeln(result);
    return result;
  }

  /// Code

  @override
  Markdown coded(Markdown message) {
    final result = _writer.coded(message);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown code(
    String message, {
    String? language,
    CodeFenceStyle style = CodeFenceStyle.tripleBackticks,
  }) {
    final result = _writer.code(language: language, message, style: style);
    _buffer.writeln(result);
    return result;
  }

  /// Styling

  @override
  Markdown blockQuote(Iterable<Markdown> lines) {
    final result = _writer.blockQuote(lines);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown horizontalRule([
    HorizontalRuleStyle style = HorizontalRuleStyle.asterisks,
  ]) {
    final result = _writer.horizontalRule(style);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown admonition(String type) {
    final result = _writer.admonition(type);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown alert(MarkdownAlertType type, Iterable<Markdown> lines) {
    final result = _writer.alert(type, lines);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown comment(String commentName, String message) {
    final result = _writer.comment(commentName, message);
    _buffer.writeln(result);
    return result;
  }

  /// Links

  @override
  Markdown link(MarkdownTextLink link, [Markdown? message]) {
    final result = _writer.link(link, message);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown image(MarkdownImageLink url, [String? message]) {
    final result = _writer.image(url, message);
    _buffer.writeln(result);
    return result;
  }

  /// Complex structures

  @override
  Markdown table(List<TableHeader> headers, List<List<String>> rows) {
    final result = _writer.table(headers, rows);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown list(List<ListItem> items) {
    final result = _writer.list(items);
    _buffer.writeln(result);
    return result;
  }

  @override
  Markdown taskList(List<TaskListItem> items) {
    final result = _writer.taskList(items);
    _buffer.writeln(result);
    return result;
  }
}
