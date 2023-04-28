import 'package:flutter/material.dart';
import 'package:mobile_app/db/db_handler.dart';

class MyDialog extends StatelessWidget {
  final String itemName;
  final String documentId;
  final Function() removeFunc;
  const MyDialog({Key? key, required this.itemName, required this.documentId,  required  this.removeFunc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Remove"),
      content: Text("Are you sure that you want to remove $itemName?"),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('No'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Yes'),
          onPressed: (){
            removeFunc();
              Navigator.of(context).pop();
          },
        )
      ],
    );
    ;
  }
}
