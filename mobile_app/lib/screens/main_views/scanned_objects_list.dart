import 'package:flutter/material.dart';
import 'package:mobile_app/utils/item.dart';
import 'package:mobile_app/widgets/general_list.dart';

class InventoryList extends StatelessWidget {
   InventoryList({Key? key}) : super(key: key);

  final List<Item> items = [
  Item(
  barcode: "222",
  name: "Przykład0",
  date: "",
  type: "",
  value: "",
  amount: "",
  description: "",
  unit: ""),
  Item(
  barcode: "222",
  name: "Przykład1",
  date: "",
  type: "",
  value: "",
  amount: "",
  description: "",
  unit: ""),
  Item(
  barcode: "222",
  name: "Przykład2",
  date: "",
  type: "",
  value: "",
  amount: "",
  description: "",
  unit: "")
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GeneralList(items: items,),
        floatingActionButton: FloatingActionButton(
          onPressed:() {

          },
          child: Icon(Icons.add),
        ),
    );
  }
}
