import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:mobile_app/db/data_models/inventory.dart';
import 'package:mobile_app/db/data_models/item.dart';
import 'package:mobile_app/db/db_handler.dart';
import 'package:mobile_app/utils/search_model.dart';
import 'package:mobile_app/widgets/dialog/add_item_to_inventory.dart';
import 'package:mobile_app/widgets/items_builder.dart';
import 'package:provider/provider.dart';

class InventoryDetailsView extends StatefulWidget {
  const InventoryDetailsView({Key? key, required this.inventory})
      : super(key: key);
  final Inventory inventory;
  @override
  State<InventoryDetailsView> createState() => _InventoryDetailsViewState();
}

class _InventoryDetailsViewState extends State<InventoryDetailsView> {
  final DBHandler _db = DBHandler();
  final SearchModel _searchModel = new SearchModel();
  @override
  Widget build(BuildContext context) {
    List<Item> items =
        widget.inventory.items.map((e) => Item.fromJSON(e)).toList();
    void onRemove(Item item) async {
      await _db.removeFromInventory(item, widget.inventory);
      setState(() {});
    }

    return Scaffold(
      appBar: EasySearchBar(
        title: Text(widget.inventory.title),
        onSearch: (query) => _searchModel.setSearchQueryTo(query),
        foregroundColor: Colors.white,
        isFloating: false,
      ),
      body: ChangeNotifierProvider(
          create: (context) => _searchModel,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150,
                    child: Text(widget.inventory.description),
                  ),
                  Text(
                    "Items",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.left,
                  ),
                  Flexible(
                      child: Consumer<SearchModel>(
                          builder: (context, searchModel, child) =>
                              ItemsBuilder(
                                items: items
                                    .where((item) => item.title
                                        .toLowerCase()
                                        .contains(searchModel.searchBarQuery))
                                    .toList(),
                                onRemove: onRemove,
                              )))
                ],
              ))),
      floatingActionButton: ExpandableFab(
        children: [
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.edit),
            onPressed: () async {},
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.add),
            onPressed: () async {
              var temp = await showDialog(
                  context: context,
                  builder: (BuildContext builder) => AddItemToInventoryDialog(
                        items: _db.getItems(),
                      ));
              if (temp != null) {
                temp = temp as Item;
                temp = temp.toMap();
                temp["listID"] = widget.inventory.documentId;
                _db.addToInventory(temp);
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
