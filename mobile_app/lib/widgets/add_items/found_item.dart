import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models/inventory.dart';
import 'package:mobile_app/db/data_models/item.dart';
import 'package:mobile_app/db/db_handler.dart';

class FoundScreen extends StatefulWidget {
  FoundScreen({Key? key, required this.item, required this.barcode})
      : super(key: key);
  Item item;
  String barcode;

  @override
  State<FoundScreen> createState() => _FoundScreenState();
}

class _FoundScreenState extends State<FoundScreen> {
  TextEditingController _controller = TextEditingController();
  final _padding = 20.0;
  final DBHandler _db = DBHandler();

  Inventory? inventory;
  @override
  void initState() {
    _controller.text = widget.item.description;
    super.initState();
  }

  void onChange(Inventory chosen) {
    setState(() {
      inventory = chosen;
    });
  }

  Future<void> onSubmit() async {
    Map<String, dynamic> dataCollected = widget.item.toMap();
    dataCollected["listID"] = inventory!.documentId;
    await _db.addToInventory(dataCollected);
  }

  //TODO: jeżeli będzie czas: pozmieniać kod tak aby co wybór nie wykonywał
  // operacji read'a z bazy danych
  Widget _dropDownButton<T>(
          T? value, Future<List<T>> list, Function(T) onChange) =>
      FutureBuilder<List<T>>(
          future: list,
          builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
            if (snapshot.hasData) {
              value = snapshot.data![0];
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: _padding),
                  child: DropdownButtonFormField<T>(
                    decoration: const InputDecoration(
                      labelText: "Item type",
                      border: OutlineInputBorder(),
                    ),
                    value: value,
                    items: snapshot.data!
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    onChanged: (T? value) {
                      onChange(value!);
                    },
                    isExpanded: true,
                    validator: (value) {
                      if (value == null) {
                        return "You must choose an option";
                      }
                    },
                  ));
            } else {
              return Container();
            }
          });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Found item: ${widget.item.title}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Barcode: ${widget.barcode}",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Text(
              "Item Description",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                height: 100,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(widget.item.description),
                )),
            Text(
              "Unit: ${widget.item.unit} Quantity: ${widget.item.quantity}",
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            _dropDownButton(inventory, _db.getInventories(), onChange),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      onSubmit();
                      Navigator.pop(context);
                    },
                    child: Text("Add to chosen list")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Go back"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
