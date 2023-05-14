import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models/item.dart';

class ItemsBuilder extends StatelessWidget {
  const ItemsBuilder({Key? key, required this.items}) : super(key: key);
  final List<Item> items;
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
                      return AlertDialog(
                        content: Text(items[index].description),
                      );
                    });
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // onRemove(inventories[index].documentId);
                },
              ),
            ));
  }
}
