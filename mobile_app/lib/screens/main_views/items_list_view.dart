import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models/item.dart';
import 'package:mobile_app/db/db_handler.dart';
import 'package:mobile_app/widgets/add_inventory.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:mobile_app/widgets/items_builder.dart';
import 'package:provider/provider.dart';

import '../../utils/search_model.dart';

class ItemsListView extends StatefulWidget {
  const ItemsListView({Key? key}) : super(key: key);

  @override
  State<ItemsListView> createState() => _ItemsListViewState();
}

class _ItemsListViewState extends State<ItemsListView> {
  final DBHandler _db = DBHandler();
  late Future<List<Item>> items;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = _db.getItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: items,
          builder: ((context, snapshot) {
            return Consumer<SearchModel>(
                builder: (context, searchModel, child) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                List<Item> items = snapshot.data as List<Item>;
                if (items.isEmpty) {
                  return const Center(
                    child: Text("You have no items"),
                  );
                }
                items = items
                    .where((item) => item.title
                        .toLowerCase()
                        .contains(searchModel.searchBarQuery))
                    .toList();
                return ItemsBuilder(
                  items: items,
                  onRemove: onRemove,
                );
              }
            });
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
                    return AddInventory(
                        onCreate: onCreate, titleText: "Add new item type");
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
                    return AddInventory(
                        onCreate: onCreate, titleText: "Add new item type");
                  });
            },
          ),
        ],
      ),
    );
  }

  void onCreate(List<String> params) async {
    // if (success) {
    setState(() {
      print("object");
    });
    // }
  }

  void onRemove(Item item) async {
    print("Kurwa");
    bool success = await _db.removeItem(item.itemId!);

    if (success) {
      setState(() {
        items = _db.getItems();
      });
    }
  }
}
