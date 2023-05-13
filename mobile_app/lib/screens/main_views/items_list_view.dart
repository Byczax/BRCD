import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models/item.dart';
import 'package:mobile_app/db/db_handler.dart';
import 'package:mobile_app/widgets/add_inventory.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:mobile_app/widgets/items_builder.dart';


class ItemsListView extends StatefulWidget {
  const ItemsListView({Key? key}) : super(key: key);

  @override
  State<ItemsListView> createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {
  final DBHandler _db = DBHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _db.getItems(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<Item> inventories = snapshot.data as List<Item>;
              if (inventories.isEmpty) {
                return const Center(
                  child: Text("You have no inventories"),
                );
              }
              return ItemsBuilder(items: inventories);
            }
          })),

        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          children: [
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext builder) {
                      return AddInventory(onCreate: onCreate, titleText: "Add new item type");
                    });
              },
            ),
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext builder) {
                      return AddInventory(onCreate: onCreate, titleText: "Add new item type");
                    });
              },
            ),
          ],
        ),
    );
  }

  void onCreate(List<String> params) async {
    // var itemType = ItemType(params[0], params[1]);
    // bool success = await _db.addItemType(itemType);
    // if (success) {
      setState(() {
        print("object");
      });
    // }
  }

  void onRemove(String documentId) async {
    bool success = await _db.removeInventory(documentId);

    if (success) {
      setState(() {});
    }
  }
}
