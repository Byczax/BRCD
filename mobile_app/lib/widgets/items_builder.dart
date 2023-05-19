import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models/item.dart';
import 'package:mobile_app/widgets/dialog/item_dialog.dart';

class ItemsBuilder extends StatelessWidget {
  const ItemsBuilder({Key? key, required this.items, required this.onRemove}) : super(key: key);
  final List<Item> items;
  final void Function(Item) onRemove;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => ListTile(
              title: Text(items[index].title),
              onTap: () {
                // TODO: Add here dialog which will display details
                showDialog(
                    context: context,
                    builder: (BuildContext builder) {
                      return ItemDialog(item: items[index]);
                    });
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  onRemove(items[index]);
                  // onRemove(inventories[index].documentId);
                },
              ),
            ));
  }
}
