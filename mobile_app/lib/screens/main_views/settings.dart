import 'package:flutter/material.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  bool _isOffline = false;
  bool _requireConfirmation = false;
  bool _saveInformation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CheckboxListTile(
                  key: Key("confirmation-checkbox"),
                  value: _requireConfirmation,
                  onChanged: (value) {
                    setState(() {
                      _requireConfirmation = value!;
                    });
                  },
                  title: Text("Pokazuj potwierdzenie informacji"),
                  controlAffinity: ListTileControlAffinity.leading),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CheckboxListTile(
                  key: Key("save-checkbox"),
                  value: _saveInformation,
                  onChanged: (value) {
                    setState(() {
                      _saveInformation = value!;
                    });
                  },
                  title: Text("Zapisuj zeskanowane produkty"),
                  controlAffinity: ListTileControlAffinity.leading),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CheckboxListTile(
                key: Key("offline-checkbox"),
                value: _isOffline,
                onChanged: (value) {
                  setState(() {
                    _isOffline = value!;
                  });
                },
                title: Text("Tryb offline"),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
          ],
        ));
  }
}
