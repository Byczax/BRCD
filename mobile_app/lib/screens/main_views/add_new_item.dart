import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/barcode_scanner.dart';

class BarCodeScreen extends StatelessWidget {
  const BarCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: BarcodeScan());
  }
}
