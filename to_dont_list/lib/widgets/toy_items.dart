import 'package:flutter/material.dart';
import 'package:to_dont_list/objects/toy.dart';

typedef ToyListChangedCallback = Function(Toy toy, bool completed);
typedef ToyListRemovedCallback = Function(Toy toy);

class ToyListItem extends StatelessWidget {
  ToyListItem(
      {required this.toy,
      required this.got,
      required this.onListChanged,
      required this.onDeleteItem})
      : super(key: ObjectKey(toy));

  final Toy toy;
  final bool got;

  final ToyListChangedCallback onListChanged;
  final ToyListRemovedCallback onDeleteItem;

  Color _getColor(BuildContext context) {
    return toy.color;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onListChanged(toy, got);
      },
      onLongPress: got
          ? () {
              onDeleteItem(toy);
            }
          : null,
      leading: CircleAvatar(
        backgroundColor: toy.color,
      ),
      title: Text(
        toy.name,
        style: _getTextStyle(context),
      ),
    );
  }
}
