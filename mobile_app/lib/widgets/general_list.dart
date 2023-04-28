import "package:flutter/material.dart";
import 'package:mobile_app/db/data_models.dart';
import 'package:mobile_app/utils/item.dart';
import 'package:mobile_app/widgets/dialog.dart';

class GeneralList extends StatelessWidget {
  Function(String documentId) onRemove;

  GeneralList({Key? key, required this.items, required this.onRemove}) : super(key: key);
  // nazwa przedmiotu, data przyjęcia
  final Future<List<Inventory>> items;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: items,
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<Inventory> inventories = snapshot.data as List<Inventory>;
            if (inventories.isEmpty) {
              return const Center(
                child: Text("You have no inventories"),
              );
            }
            return ListView.builder(
                itemCount: inventories.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(inventories[index].title),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          onRemove(inventories[index].documentId);
                        },
                      ),
                    ));
          }
        }));
  }
}
