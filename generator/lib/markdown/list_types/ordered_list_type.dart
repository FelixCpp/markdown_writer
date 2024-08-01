import 'package:generator/markdown/list_types/list_type.dart';

final class OrderedListType implements ListType {
  final int offset;
  const OrderedListType([this.offset = 1]);

  @override
  String getValue(int index) => '$index.';
}
