import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:mobile_app/db/data_models/inventory.dart';
import 'package:mobile_app/db/db_handler.dart';
import 'package:mobile_app/widgets/add_inventory.dart';
import 'package:mobile_app/screens/inventory_details_view.dart';
import 'package:mobile_app/widgets/dialog/comparer_dialog.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({Key? key}) : super(key: key);

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  late DBHandler _db;
  late Future<List<Inventory>> inventories;
  @override
  void initState() {
    super.initState();
    _db = DBHandler();
    inventories = _db.getInventories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: inventories,
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
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => InventoryDetailsView(
                                      inventory: inventories[index])));
                        },
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            onRemove(inventories[index].documentId);
                          },
                        ),
                      ));
            }
          })),
      floatingActionButton: ExpandableFab(
          children: [
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.edit),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext builder) =>
                        ComparerDialog( inventories: inventories));
              },
            ),
            FloatingActionButton.small(
              heroTag: null,
              child: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext builder) =>
                        AddInventory(titleText: "Add new inventory", onCreate: onCreate));
              },
            ),
          ],
        ),
      floatingActionButtonLocation: ExpandableFab.location,
    );
  }

  // TODO: Add behaviour when we deal with cache
  void onCreate(List<String> inventory) async {
    final temp = Inventory(inventory[0], inventory[1], [], null);
    bool success = await _db.addInventory(temp);
    if (success) {
      setState(() {});
    }
  }

  void onRemove(String documentId) async {
    bool success = await _db.removeInventory(documentId);

    if (success) {
      setState(() {});
    }
  }
}
