import 'package:flutter/material.dart';
import 'package:mobile_app/db/data_models.dart';
import 'package:mobile_app/db/db_handler.dart';

class AddInventory extends StatelessWidget {
  AddInventory({Key? key, required this.onCreate, required this.titleText}) : super(key: key);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final String titleText;
  final _formKey = GlobalKey<FormState>();
  final Function(List<String>) onCreate;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Container(
        height: 200,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Name"),
                    controller: _titleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "this field is required";
                      }
                      return null;
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Description",
                      alignLabelWithHint: true),
                  minLines: 3,
                  maxLines: 4,
                  controller: _descriptionController,
                ),
              )
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                List<String> parameters = [
                  _titleController.text,
                  _descriptionController.text
                ];
                  onCreate(parameters);
                Navigator.pop(context);
              }
            },
            child: Text("Create")),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"))
      ],
    );
  }
}
