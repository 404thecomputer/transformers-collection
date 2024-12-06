// Started with https://docs.flutter.dev/development/ui/widgets-intro
import 'package:flutter/material.dart';
// import 'package:to_dont_list/objects/item.dart';
import 'package:to_dont_list/objects/toy.dart';
import 'package:to_dont_list/widgets/toy_items.dart';
import 'package:to_dont_list/widgets/toy_dialog.dart';

class ToyList extends StatefulWidget {
  const ToyList({super.key});

  @override
  State createState() => _ToyListState();
}

class _ToyListState extends State<ToyList> {
  final List<Toy> items = [Toy(name: "Legacy Core Optimus Prime", color: SideColor.a.rgbcolor)];
  final _itemSet = <Toy>{};

  void _handleListChanged(Toy item, bool completed) {
    setState(() {
      // When a user changes what's in the list, you need
      // to change _itemSet inside a setState call to
      // trigger a rebuild.
      // The framework then calls build, below,
      // which updates the visual appearance of the app.

      items.remove(item);
      if (!completed) {
        print("Completing");
        _itemSet.add(item);
        items.add(item);
      } else {
        print("Making Undone");
        _itemSet.remove(item);
        items.insert(0, item);
      }
    });
  }

  void _handleDeleteItem(Toy item) {
    setState(() {
      print("Deleting item");
      items.remove(item);
    });
  }

  void _handleNewItem(String itemText, Color itemColor, TextEditingController textController) {
    setState(() {
      print("Adding new item");
      Toy item = Toy(name: itemText, color:itemColor);
      items.insert(0, item);
      textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Transformers Collection'),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: items.map((item) {
            return ToyListItem(
              toy: item,
              got: _itemSet.contains(item),
              onListChanged: _handleListChanged,
              onDeleteItem: _handleDeleteItem,
            );
          }).toList(),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return ToyDialog(onListAdded: _handleNewItem);
                  });
            }));
  }
}

void main() {
  runApp(const MaterialApp(
    title: 'Transformer Collector',
    home: ToyList(),
  ));
}