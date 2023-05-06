import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models.dart';
import 'package:mobile_app/db/data_models/item.dart';
import 'package:mobile_app/db/data_models/item_type.dart';
import 'package:mobile_app/db/db_handler.dart';
import 'package:mobile_app/utils/item_arguments.dart';
import 'package:mobile_app/widgets/add_items/found_item.dart';
import 'package:mobile_app/widgets/add_items/item_form.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({Key? key, required this.barcode}) : super(key: key);
  final ItemBarcode barcode;
  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  //TODO: Here handle case whether we found data in database or in local memory.
  final _db = DBHandler();
  void _buildDialog(ItemType item) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Item ${item.name} found in database'),
          content: Text(' ${item.description}\n'
              // ' ${item.amount}\n'
              'What do you wish to do?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text("Don't add"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Continue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _loadingScreen() => Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Text("Checking data from sources")
          ]));

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as ItemBarcode;
    return Scaffold(
        appBar: AppBar(
          title: const Text("New item"),
        ),
        body: FutureBuilder<dynamic>(
            future: _db.checkIfBarcodeExists(widget.barcode.barcode),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data! != false) {
                  return FoundScreen(
                      item: snapshot.data! as Item,
                      barcode: widget.barcode.barcode);
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   _buildDialog(snapshot.data! as ItemType);
                  // });
                  //   print("Ide tu");
                }
                return ItemForm(barcode: widget.barcode.barcode);
              } else if (snapshot.hasError) {
                return const Text("Unexpected error");
              } else {
                print("cos");
                return _loadingScreen();
              }
            }) //ItemForm(barcode: args.barcode,),
        );
  }
}
