import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _padding = 10.0;
  final _buttonPadding = 15.0;
  final _formKey = GlobalKey<FormState>();

  final List<TextEditingController> _controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _generateTextField(
          {required String label,
          required TextEditingController controller,
          bool isRequired = true,
          int? minLinesNum,
          int maxlinesNum = 1,
          TextInputType? keyboardType}) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: _padding, horizontal: _padding),
        child: Card(
          child: TextFormField(
            controller: controller,
            maxLines: maxlinesNum,
            minLines: minLinesNum,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (isRequired && (value == null || value.isEmpty)) {
                return "Enter some text";
              }
              return null;
            },
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Skaner"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              _generateTextField(label: "Name", controller: _controllers[0]),
              _generateTextField(
                  label: "Bar code", controller: _controllers[1]),
              _generateTextField(label: "Date", controller: _controllers[2]),
              _generateTextField(label: "Type", controller: _controllers[3]),
              _generateTextField(label: "Value", controller: _controllers[4]),
              _generateTextField(label: "Amount", controller: _controllers[5]),
              _generateTextField(label: "Unit", controller: _controllers[6]),
              _generateTextField(
                  label: "Item description (optional",
                  controller: _controllers[7],
                  keyboardType: TextInputType.multiline,
                  minLinesNum: 3,
                  maxlinesNum: 5,
                  isRequired: false),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("jest ok");
                    }
                  },
                  child: Text("Save"),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(_buttonPadding)),
                ),
              )
            ],
          ),
        ));
  }
}
