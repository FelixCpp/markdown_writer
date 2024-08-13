import 'package:markdown_writer/src/markdown.dart';
import 'package:markdown_writer/src/markdown_entry.dart';

final class Linebreak implements MarkdownEntry {
  final int spaces;

  const Linebreak({this.spaces = 2})
      : assert(spaces >= 2, 'spaces must be at least 2 for a valid linebreak');

  @override
  Markdown toMarkdown() {
    return ' ' * spaces;
  }
}
