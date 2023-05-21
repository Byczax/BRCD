import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models/inventory.dart';
import 'package:mobile_app/db/data_models/item.dart';

class CompareListViews extends StatelessWidget {
  const CompareListViews({
    Key? key,
    required this.inventory1,
    required this.inventory2,
  }) : super(key: key);
  final Inventory inventory1;
  final Inventory inventory2;
  @override
  Widget build(BuildContext context) {
    final items1 = inventory1.items.map((e) => Item.fromJSON(e)).toList();
    final items2 = inventory2.items.map((e) => Item.fromJSON(e)).toList();
    final List<Item> inCommon = items1
        .where((element) =>
            items2.any((comparedTo) => element.title == comparedTo.title))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("Compared lists"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: inCommon.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(inCommon[index].title),
            );
          }),
    );
  }
}
