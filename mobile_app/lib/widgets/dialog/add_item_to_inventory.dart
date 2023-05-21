import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models/item.dart';

class AddItemToInventoryDialog extends StatelessWidget {
  AddItemToInventoryDialog({Key? key, required this.items}) : super(key: key);

  final Future<List<Item>> items;
  final _padding = 20.0;
  Item? chosenItem;

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
    return AlertDialog(
      title: const Text("Add item to inventory"),
      content: SizedBox(
          height: 100,
          child: _dropDownButton(chosenItem, items, (p0) {
            chosenItem = p0;
          })),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Compare'),
          onPressed: () {
            // removeFunc();
            if (chosenItem != null) {
              Navigator.pop(context, chosenItem!);
            } else {
              Navigator.of(context).pop();
            }
          },
        )
      ],
    );
  }
}
