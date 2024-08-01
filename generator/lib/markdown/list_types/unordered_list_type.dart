import 'package:generator/markdown/list_types/list_type.dart';

enum UnorderedListTypeIndicator {
  asterisk,
  plus,
  minus,
}

final class UnorderedListType implements ListType {
  final UnorderedListTypeIndicator indicator;
  const UnorderedListType(this.indicator);

  @override
  String getValue(int index) => switch (indicator) {
        UnorderedListTypeIndicator.asterisk => '*',
        UnorderedListTypeIndicator.plus => '+',
        UnorderedListTypeIndicator.minus => '-',
      };
}
