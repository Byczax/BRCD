import 'package:flutter/material.dart';
import 'package:mobile_app/utils/item.dart';
import 'package:mobile_app/utils/item_arguments.dart';
import 'package:mobile_app/widgets/item_form.dart';

class NewItemScreen extends StatefulWidget {
  const NewItemScreen({Key? key}) : super(key: key);

  @override
  State<NewItemScreen> createState() => _NewItemScreenState();
}

class _NewItemScreenState extends State<NewItemScreen> {
  //TODO: Here handle case whether we found data in database or in local memory.
  // We propably intent to check all the lists that we are having available.
  final Future<Item> _calculation = Future<Item>.delayed(
    const Duration(seconds: 2),
    () => Item(
        barcode: "12321511",
        name: "Kurczak",
        date: "25.01.2022",
        type: "jedzenie",
        value: "inf",
        amount: "42",
        description: "",
        unit: "kg"),
  );

  Future<void> _buildDialog(Item item) async {
    Future.delayed(
        const Duration(seconds: 0),
        () => showDialog(
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
            ));
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
    final args = ModalRoute.of(context)!.settings.arguments as ItemBarcode;
    return Scaffold(
        appBar: AppBar(
          title: const Text("New item"),
        ),
        body: FutureBuilder<Item>(
            future: _calculation,
            builder: (BuildContext context, AsyncSnapshot<Item> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.name.isNotEmpty) {
                  _buildDialog(snapshot.data!);
                }
                return ItemForm(barcode: args.barcode);
              } else if (snapshot.hasError) {
                return const Text("No i dupa");
              } else {
                return _loadingScreen();
              }
            }) //ItemForm(barcode: args.barcode,),
        );
  }
}
