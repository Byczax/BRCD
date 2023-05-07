import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:mobile_app/screens/main_views/new_item_screen.dart';
import 'package:mobile_app/utils/item_arguments.dart';
import 'package:mobile_app/utils/pdf/pdf_service.dart';

import '../utils/pdf/model/product.dart';

class BarcodeScan extends StatefulWidget {
  const BarcodeScan({Key? key}) : super(key: key);

  @override
  State<BarcodeScan> createState() => _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  final PdfInvoiceService service = PdfInvoiceService();
  int number = 0;

  List<Product> products = [
    Product("Membership", 9.99, 19),
    Product("Nails", 0.30, 19),
    Product("Hammer", 26.43, 19),
    Product("Hamburger", 5.99, 7),
  ];

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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewItemScreen(
                  barcode: ItemBarcode(barcode: barcodeScanRes),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      return Container(
          alignment: Alignment.center,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    key: const Key("ScannerButton"),
                    onPressed: () => scanBarcodeNormal(),
                    child: const Text('Start barcode scan')),
                ElevatedButton(
                    key: const Key("PdfButton"),
                    onPressed: () async {
                      final data = await service.createInvoice(products);
                      service.savePdfFile("invoice_$number", data);
                      number++;
                    },
                    child: const Text('Display PDF')),
              ]));
    });
  }
}
