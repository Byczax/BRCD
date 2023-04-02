import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScann extends StatefulWidget {
  const BarcodeScann({Key? key}) : super(key: key);

  @override
  State<BarcodeScann> createState() => _BarcodeScannState();
}

class _BarcodeScannState extends State<BarcodeScann> {
  String _scanBarcode = "Unknown";

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Skaner"),
      ),
      body: Builder(builder: (BuildContext context) {
        return Container(
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      key: const Key("ScannerButton"),
                      onPressed: () => scanBarcodeNormal(),
                      child: const Text('Start barcode scan')),
                  Text('Scan result : $_scanBarcode\n',
                      key: const Key("barcode"),
                      style: const TextStyle(fontSize: 20))
                ]));
      }),
    );
  }
}
