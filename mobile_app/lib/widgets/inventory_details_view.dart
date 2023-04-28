import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models.dart';

class InventoryDetailsView extends StatelessWidget {
  final Inventory inventory;
  InventoryDetailsView({Key? key, required this.inventory})
      : super(key: key);

  final List<dynamic> dupa = [
    "Alibaba",
    "Alleluja",
    "ss",
    "ss",
    "Alibaba",
    "Alleluja",
    "ss",
    "ss",
    "Alibaba",
    "Alleluja",
    "ss",
    "ss",
    "Alibaba",
    "Alleluja",
    "ss",
    "ss",

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(inventory.title),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  child: Text(inventory.description),
                ),

                Text(
                  "Items",
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.left,
                ),
                // SizedBox(
                //   height:,
                  //child:
                Flexible(child:
            ListView.builder(
                      // scrollDirection: Axis.vertical,
                      // shrinkWrap: true,
                      itemCount: dupa.length,
                      itemBuilder: (context, index) => ListTile(
                        title: Text(dupa[index]),
                        trailing: IconButton(icon:  Icon(Icons.check_box_outline_blank), onPressed: (){},),

                      )),
                )
              ],
            )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (BuildContext builder) =>
              Dialog(
                
              ))
        },
        child: Icon(Icons.add),
      ),
    );

  }
}
