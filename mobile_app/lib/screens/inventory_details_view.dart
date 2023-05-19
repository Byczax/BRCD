import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:mobile_app/db/data_models/inventory.dart';
import 'package:mobile_app/db/data_models/item_type.dart';
import 'package:mobile_app/db/db_handler.dart';
import 'package:mobile_app/utils/pdf/pdf_service.dart';

import '../utils/pdf/model/product.dart';

class InventoryDetailsView extends StatefulWidget {
  const InventoryDetailsView({Key? key, required this.inventory})
      : super(key: key);
  final Inventory inventory;

  @override
  State<InventoryDetailsView> createState() => _InventoryDetailsViewState();
}

class _InventoryDetailsViewState extends State<InventoryDetailsView> {
  final DBHandler _db = DBHandler();

  @override
  Widget build(BuildContext context) {
    final PdfInvoiceService service = PdfInvoiceService();
    int number = 0;

    List<Product> products = [
      Product("Oleju", "Szanowany olej Pana Makłowicza", "Litr", 20.7, 3.50,
          "Papryka kolejna"),
      Product("Gwoździe", "Zdzisław zgubił gwoździe", "szt.", 500, 0.30,
          "Gwoździe do trumny"),
      Product(
          "Młotek", "Do wbijania gwoździ", "szt.", 2, 30.57, "dzięki, działa"),
      Product("Hamburger", "Dla głodnego nic trudnego", "szt.", 5, 2.5,
          "Przed inflacją to było"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.inventory.title),
      ),
      body: Padding(
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
                  child: ListView.builder(
                // scrollDirection: Axis.vertical,
                // shrinkWrap: true,
                itemCount: widget.inventory.items.length,
                itemBuilder: (context, index) => FutureBuilder(
                    future: _db.getItemType(
                        widget.inventory.items[index]["itemTypeID"]),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var itemType = snapshot.data as ItemType;
                        return ListTile(
                          title: Text(itemType.name),
                        );
                      } else {
                        return Container();
                      }
                    }),
              )),
            ],
          )),
      floatingActionButton: ExpandableFab(
        children: [
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.edit),
            onPressed: () async {
              // final dupa = await showDialog(
              //     context: context,
              //     builder: (BuildContext builder) =>
              //         ComparerDialog(inventories: inventories));
              // if (dupa != null) {
              //   final temp = dupa as List<Inventory>;
              //   Navigator.of(context).push(MaterialPageRoute(
              //       builder: (builder) => CompareListViews(
              //           inventory1: temp[0], inventory2: temp[1])));
              // }
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.add),
            onPressed: () {},
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.edit_document),
            onPressed: () async {
              final data = await service.createInvoice(products);
              service.savePdfFile("invoice_$number", data);
              number++;
            },
          ),
        ],
      ),
    );
  }
}
