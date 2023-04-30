import 'package:flutter/material.dart';
import 'package:mobile_app/db/db_handler.dart';
import 'package:mobile_app/utils/item.dart';
import 'package:mobile_app/utils/item_arguments.dart';
import 'package:mobile_app/widgets/item_form.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({Key? key, required this.barcode}) : super(key: key);
  final ItemBarcode barcode;
  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  //TODO: Here handle case whether we found data in database or in local memory.
  final _db = DBHandler();

  void _buildDialog(Item item) async {
        showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Item found in database'),
                  content: Text('${item.name} \n'
                      ' ${item.value}\n'
                      ' ${item.amount}\n'
                      'What do you wish to do?'),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Edit data'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Add to list'),
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/logged_in'));
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
                  _buildDialog(snapshot.data! as Item);
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
