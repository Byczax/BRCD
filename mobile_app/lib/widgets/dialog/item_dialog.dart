import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_app/db/data_models/item.dart';

class ItemDialog extends StatelessWidget {
  final Item item;
  ItemDialog({Key? key, required this.item}) : super(key: key);
  final DateFormat formatter = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        item.title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      content: SizedBox(
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  child: Text(
                    item.description,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Text(
                  "Scan date: ${formatter.format(DateTime.parse(item.createdDate))}"),
              Divider(
                color: Colors.black,
              ),
              Text("Quantity: ${item.amount}"),
              Divider(
                color: Colors.black,
              ),
              Text("Unit: ${item.unit}"),
            ],
          )),
    );
  }
}
