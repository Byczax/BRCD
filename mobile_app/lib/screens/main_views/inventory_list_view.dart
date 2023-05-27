import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:mobile_app/db/data_models/inventory.dart';
import 'package:mobile_app/db/db_handler.dart';
import 'package:mobile_app/screens/compare_list_view.dart';
import 'package:mobile_app/screens/main_page.dart';
import 'package:mobile_app/widgets/add_inventory.dart';
import 'package:mobile_app/screens/inventory_details_view.dart';
import 'package:mobile_app/widgets/dialog/comparer_dialog.dart';
import 'package:provider/provider.dart';

import '../../utils/search_model.dart';

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
            return Consumer<SearchModel>(
              builder: (context, searchModel, child) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<Inventory> inventories =
                      snapshot.data as List<Inventory>;
                  if (inventories.isEmpty) {
                    return const Center(
                      child: Text("You have no inventories"),
                    );
                  }
                  inventories = inventories
                      .where((inventory) => inventory.title
                          .toLowerCase()
                          .contains(searchModel.searchBarQuery))
                      .toList();
                  return ListView.builder(
                      itemCount: inventories.length,
                      itemBuilder: (context, index) => Card( child:ListTile(
                            title: Text(inventories[index].title),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          InventoryDetailsView(
                                              inventory: inventories[index])));
                            },
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                onRemove(inventories[index].documentId);
                              },
                            ),
                          )));
                }
              },
            );
          })),
      floatingActionButton: ExpandableFab(
        children: [
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.edit),
            onPressed: () async {
              final dupa = await showDialog(
                  context: context,
                  builder: (BuildContext builder) =>
                      ComparerDialog(inventories: inventories));
              if (dupa != null) {
                final temp = dupa as List<Inventory>;
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (builder) => CompareListViews(
                        inventory1: temp[0], inventory2: temp[1])));
              }
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext builder) => AddInventory(
                      titleText: "Add new inventory", onCreate: onCreate));
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
      setState(() {
        inventories = _db.getInventories();
      });
    }
  }

  void onRemove(String documentId) async {
    bool success = await _db.removeInventory(documentId);

    if (success) {
      setState(() {
        inventories = _db.getInventories();
      });
    }
  }
}
