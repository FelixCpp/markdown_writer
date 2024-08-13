import 'package:markdown_writer/src/markdown.dart';
import 'package:markdown_writer/src/markdown_entry.dart';

sealed class HeadingSyntax {
  Markdown format(Markdown text);
}

final class CoreHeadingSyntax implements HeadingSyntax {
  final int level;
  final String? id;

  const CoreHeadingSyntax(this.level, {this.id})
      : assert(level >= 1 && level <= 6, 'level must be between 1 and 6');

  factory CoreHeadingSyntax.h1({String? id}) => CoreHeadingSyntax(1, id: id);
  factory CoreHeadingSyntax.h2({String? id}) => CoreHeadingSyntax(2, id: id);
  factory CoreHeadingSyntax.h3({String? id}) => CoreHeadingSyntax(3, id: id);
  factory CoreHeadingSyntax.h4({String? id}) => CoreHeadingSyntax(4, id: id);
  factory CoreHeadingSyntax.h5({String? id}) => CoreHeadingSyntax(5, id: id);
  factory CoreHeadingSyntax.h6({String? id}) => CoreHeadingSyntax(6, id: id);

  @override
  Markdown format(Markdown text) {
    final idExtension = id != null ? ' {#$id}' : '';
    return '${'#' * level} $text$idExtension';
  }
}

final class AlternateHeadingSyntax implements HeadingSyntax {
  final String character;
  final int? length;
  final String? id;

  const AlternateHeadingSyntax(this.character, {this.length, this.id})
      : assert(character.length == 1, 'character must be a single character'),
        assert(length == null || length >= 3, 'length must be at least 3');

  @override
  Markdown format(Markdown text) {
    final repetitions = length ?? text.length;
    final idExtension = id != null ? ' {#$id}' : '';
    return '$text$idExtension\n${character * repetitions}';
  }
}

final class Heading implements MarkdownEntry {
  final HeadingSyntax syntax;
  final Markdown text;

  const Heading({required this.syntax, required this.text});

  @override
  Markdown toMarkdown() {
    return syntax.format(text);
  }
}
