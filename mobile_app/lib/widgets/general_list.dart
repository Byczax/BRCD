import "package:flutter/material.dart";
import 'package:mobile_app/utils/item.dart';
import 'package:mobile_app/widgets/dialog.dart';

class GeneralList extends StatelessWidget {
  const GeneralList({Key? key, required this.items}) : super(key: key);
  // nazwa przedmiotu, data przyjęcia
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].name),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return MyDialog(itemName: items[index].name);
                    });
              },
            ),
            onTap: () {
              print("I am here $index");
            },
          );
        });
  }
}
