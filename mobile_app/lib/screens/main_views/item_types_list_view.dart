import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models.dart';
import 'package:mobile_app/db/data_models/item_type.dart';
import 'package:mobile_app/db/db_handler.dart';
import 'package:mobile_app/widgets/add_inventory.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';


class ItemTypesListView extends StatefulWidget {
  const ItemTypesListView({Key? key}) : super(key: key);

  @override
  State<ItemTypesListView> createState() => _ItemTypesListViewState();
}

class _ItemTypesListViewState extends State<ItemTypesListView> {
  final DBHandler _db = DBHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _db.getItemTypes(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<ItemType> inventories = snapshot.data as List<ItemType>;
              if (inventories.isEmpty) {
                return const Center(
                  child: Text("You have no inventories"),
                );
              }
              return ListView.builder(
                  itemCount: inventories.length,
                  itemBuilder: (context, index) => ListTile(
                        title: Text(inventories[index].name),
                        onTap: () {
                          // TODO: Add here dialog which will display details
                          showDialog(
                              context: context,
                              builder: (BuildContext builder) {
                                return AlertDialog(
                                  content: Text(inventories[index].description),
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
          })),
      floatingActionButton: Scaffold(
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
      ),
    );
  }

  void onCreate(List<String> params) async {
    var itemType = ItemType(params[0], params[1]);
    bool success = await _db.addItemType(itemType);
    if (success) {
      setState(() {
        print("object");
      });
    }
  }

  void onRemove(String documentId) async {
    bool success = await _db.removeInventory(documentId);

    if (success) {
      setState(() {});
    }
  }
}
