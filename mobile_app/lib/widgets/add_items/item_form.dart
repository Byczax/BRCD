import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models.dart';
import 'package:mobile_app/db/data_models/inventory.dart';
import 'package:mobile_app/db/data_models/item_type.dart';
import 'package:mobile_app/db/db_handler.dart';

class ItemForm extends StatefulWidget {
  const ItemForm({super.key, required this.barcode});
  final String barcode;
  @override
  State<ItemForm> createState() => _ItemFormState();
}

class _ItemFormState extends State<ItemForm> {
  final _padding = 20.0;
  final _buttonPadding = 15.0;
  final _formKey = GlobalKey<FormState>();
  ItemType? _dropdownItemType;
  Inventory? _dropdownInventory;
  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
  ];
  final DBHandler _db = DBHandler();

  @override
  void initState() {
    _controllers[0].text = widget.barcode;
    super.initState();
  }

  void onSubmit() async {
    Map<String, dynamic> dataCollected = {
      "itemTypeID": _dropdownItemType!.id,
      "dateCreated": DateTime.now().toUtc().toString(),
      "description": _controllers[1].text,
      "barcode": _controllers[0].text,
      "listID": _dropdownInventory!.documentId
    };
    await _db.addItem(dataCollected);
  }

  void updateItemType(ItemType type) {
    setState(() {
      _dropdownItemType = type;
    });
  }

  void updateInventory(Inventory inventory) {
    setState(() {
      _dropdownInventory = inventory;
    });
  }

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
                      // setState(() {
                      //   _dropdownValue = value!;
                      // });
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

  Widget _generateTextField(
          {required String label,
          required TextEditingController controller,
          bool isRequired = true,
          int? minLinesNum,
          int maxlinesNum = 1,
          bool isEnabled = true,
          TextInputType? keyboardType}) =>
      Padding(
          padding: EdgeInsets.symmetric(vertical: _padding),
          child: TextFormField(
            controller: controller,
            maxLines: maxlinesNum,
            minLines: minLinesNum,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              border: const OutlineInputBorder(),
            ),
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return "Enter some text";
              }
              return null;
            },
            enabled: isEnabled,
          ));

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: _padding, horizontal: _padding),
          child: ListView(
            children: [
              _generateTextField(
                  label: "Bar code",
                  controller: _controllers[0],
                  isEnabled: false),
              _generateTextField(
                  label: "Item description (optional)",
                  controller: _controllers[1],
                  keyboardType: TextInputType.multiline,
                  minLinesNum: 3,
                  maxlinesNum: 5,
                  isRequired: false),
              _dropDownButton<ItemType>(
                  _dropdownItemType, _db.getItemTypes(), updateItemType),
              _dropDownButton<Inventory>(
                  _dropdownInventory, _db.getInventories(), updateInventory),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      onSubmit();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(_buttonPadding)),
                  child: const Text("Save"),
                ),
              )
            ],
          ),
        ));
  }
}
