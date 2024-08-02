import 'package:markdown_writer/markdown_writer.dart';

sealed class HeadlineSyntax {
  const factory HeadlineSyntax.core({required int level}) = _CoreHeadlineSyntax;
  const factory HeadlineSyntax.alternative({int? repetitions}) =
      _AlternativeHeadlineSyntax;

  Markdown format(Markdown message);
}

final class _CoreHeadlineSyntax implements HeadlineSyntax {
  final int level;

  const _CoreHeadlineSyntax({required this.level})
      : assert(
          level >= 1 && level <= 2,
          'Headline level must be between 1 and 2',
        );

  @override
  Markdown format(Markdown message) => '${'#' * level} $message';
}

final class _AlternativeHeadlineSyntax implements HeadlineSyntax {
  final int? repetitions;
  const _AlternativeHeadlineSyntax({this.repetitions = 1});

  @override
  Markdown format(Markdown message) =>
      '$message\n${'=' * (repetitions ?? message.length)}';
}
