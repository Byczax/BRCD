import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models/inventory.dart';
import 'package:mobile_app/screens/compare_list_view.dart';

class ComparerDialog extends StatelessWidget {
  ComparerDialog({Key? key, required this.inventories}) : super(key: key);
  final Future<List<Inventory>> inventories;
  final _padding = 20.0;
  Inventory? chosen_1;
  Inventory? chosen_2;
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
      title: Text("Choose list to compare contents"),
      content: SizedBox(
        height: 250,
        child: Column(
          children: [
            _dropDownButton(this.chosen_1, inventories, (p0) {
              this.chosen_1 = p0;
            }),
            _dropDownButton(this.chosen_2, inventories, (p0) {
              this.chosen_2 = p0;
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Go back'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Compare'),
          onPressed: () {
            // removeFunc();
            if (chosen_1 != null && chosen_2 != null && chosen_1 != chosen_2) {
              Navigator.pop(context, [chosen_1!, chosen_2!]);
            } else {
              Navigator.of(context).pop();
            }
          },
        )
      ],
    );
  }
}
