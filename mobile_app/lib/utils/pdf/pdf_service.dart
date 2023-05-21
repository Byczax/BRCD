import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../db/data_models/item.dart';

class CustomRow {
  final String position;
  final String identifier;
  final String description;
  final String unit;
  final String count;
  final String price;
  final String myPrice;
  final String comments;

  CustomRow(this.position, this.identifier, this.description, this.unit,
      this.count, this.price, this.myPrice, this.comments);
}

class PdfInvoiceService {
  Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<Uint8List> createInvoice(List<Item> soldProducts) async {
    final pdf = pw.Document();

    final List<CustomRow> elements = [
      for (var product in soldProducts)
        CustomRow(
            soldProducts.indexOf(product).toString(),
            product.title,
            product.description,
            product.unit,
            product.amount.toStringAsFixed(2),
            product.price!.toStringAsFixed(2),
            (product.price! * product.amount).toStringAsFixed(2),
            "uwag brak."),
      // CustomRow(
      //   "",
      //   "Sub Total",
      //   "",
      //   "",
      //   "",
      //   "",
      //   "",
      //   "${getSubTotal(soldProducts)} EUR",
      // ),
      // CustomRow(
      //   "",
      //   "Vat Total",
      //   "",
      //   "",
      //   "",
      //   "",
      //   "",
      //   "${getVatTotal(soldProducts)} EUR",
      // ),
      // CustomRow(
      //   "",
      //   "Vat Total",
      //   "",
      //   "",
      //   "",
      //   "",
      //   "",
      //   "${(double.parse(getSubTotal(soldProducts)) + double.parse(getVatTotal(soldProducts))).toStringAsFixed(2)} EUR",
      // )
    ];
    final image = (await rootBundle.load("assets/images/placeholder.png"))
        .buffer
        .asUint8List();

    final font = await PdfGoogleFonts.nunitoExtraLight();
    String spacer = "______________________________";
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(20, 20, 20, 20),
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Image(pw.MemoryImage(image),
                        width: 100, height: 100, fit: pw.BoxFit.cover),
                    // pw.SizedBox(width: 50),
                    pw.Column(children: [
                      pw.Text(
                        'ARKUSZ SPISU Z NATURY',
                        // textAlign: TextAli,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                            fontSize: 18,
                            fontWeight: pw.FontWeight.bold,
                            font: font),
                      ),
                      pw.Text("uniwersalny",
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(font: font)),
                      // pw.Expanded(
                      //     child:
                      pw.SizedBox(width: 50),
                      pw.Text(
                          "Rodzaj inwentaryzacji\t - _________________________\nSposób przeprowadzenia\t - _________________________",
                          textAlign: pw.TextAlign.right,
                          style: pw.TextStyle(font: font))
                      // ),
                    ])
                  ]),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(spacer, style: pw.TextStyle(font: font)),
                      pw.Text("(nazwa i  adres jednoski inwentaryzacyjnej)",
                          style: pw.TextStyle(fontSize: 8, font: font)),
                      pw.Text(
                          "Skład komisji inwentaryzacyjnej (zespołu spisującego)",
                          style: pw.TextStyle(fontSize: 10, font: font)),
                      pw.Text(spacer, style: pw.TextStyle(font: font)),
                      pw.Text(spacer, style: pw.TextStyle(font: font)),
                      pw.Text(spacer, style: pw.TextStyle(font: font)),
                      pw.Text("spis rozpoczęto dn. ______ o godz. ______",
                          style: pw.TextStyle(font: font)),
                    ],
                  ),
                  pw.SizedBox(width: 50),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text(spacer, style: pw.TextStyle(font: font)),
                      pw.Text(
                          "(imię i nazwisko osoby materialnie odpowiedzialnej)",
                          style: pw.TextStyle(fontSize: 8, font: font)),
                      pw.Text("Inne osoby obecne przy spisie",
                          style: pw.TextStyle(fontSize: 10, font: font)),
                      pw.Text(spacer, style: pw.TextStyle(font: font)),
                      pw.Text(spacer, style: pw.TextStyle(font: font)),
                      pw.Text(spacer, style: pw.TextStyle(font: font)),
                      pw.Text("spis rozpoczęto dn. ______ o godz. ______",
                          style: pw.TextStyle(font: font)),
                    ],
                  )
                ],
              ),
              pw.SizedBox(height: 50),
              itemColumn(elements, font),
              pw.Text("Podpis osoby materialnie odpowiedzialnej",
                  textAlign: pw.TextAlign.left,
                  style: pw.TextStyle(font: font)),
              pw.SizedBox(height: 50),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text("Wycenił $spacer", style: pw.TextStyle(font: font)),
                  pw.Text("Sprawdził $spacer", style: pw.TextStyle(font: font)),
                ],
              )
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  pw.Expanded itemColumn(List<CustomRow> elements, pw.Font font) {
    return pw.Expanded(
      child: pw.Table(
        defaultColumnWidth: const pw.FlexColumnWidth(),
        border: pw.TableBorder.all(),
        columnWidths: const <int, pw.TableColumnWidth>{
          0: pw.FixedColumnWidth(20),
          1: pw.FlexColumnWidth(2),
          2: pw.FlexColumnWidth(3),
          3: pw.FlexColumnWidth(2),
          4: pw.FlexColumnWidth(2),
          5: pw.FlexColumnWidth(2),
          6: pw.FlexColumnWidth(2),
          7: pw.FlexColumnWidth(2),
        },
        defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
        children: <pw.TableRow>[
          firstRow(font),
          for (var element in elements)
            pw.TableRow(
              children: [
                pw.Expanded(
                    child: pw.Text(element.position,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(font: font))),
                pw.Expanded(
                    child: pw.Text(element.identifier,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(font: font))),
                pw.Expanded(
                    child: pw.Text(element.description,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(font: font))),
                pw.Expanded(
                    child: pw.Text(element.unit,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(font: font))),
                pw.Expanded(
                    child: pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(element.count,
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(font: font)))),
                pw.Expanded(
                    child: pw.Padding(
                        padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text(element.price,
                            textAlign: pw.TextAlign.right,
                            style: pw.TextStyle(font: font)))),
                pw.Expanded(
                  child: pw.Padding(
                      padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(element.myPrice,
                        textAlign: pw.TextAlign.right,
                        style: pw.TextStyle(font: font)))),
                pw.Expanded(
                    child: pw.Text(element.comments,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(font: font))),
              ],
            )
        ],
      ),
    );
  }

  pw.TableRow firstRow(pw.Font font) {
    return pw.TableRow(children: [
      pw.Expanded(
          child: pw.Text("Lp.",
              textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font))),
      pw.Expanded(
          child: pw.Text("Cecha\nSymbol\nNumer\nGatunek",
              textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font))),
      pw.Expanded(
          child: pw.Text("Nazwa (określenie)\nprzedmiotu spisywanego",
              textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font))),
      pw.Expanded(
          child: pw.Text("Jedn.\nmiary",
              textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font))),
      pw.Expanded(
          child: pw.Text("Ilość stwierdzona",
              textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font))),
      pw.Expanded(
          child: pw.Text("Cena jednostkowa",
              textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font))),
      pw.Expanded(
          child: pw.Text("Wartość",
              textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font))),
      pw.Expanded(
          child: pw.Text("Uwagi",
              textAlign: pw.TextAlign.center, style: pw.TextStyle(font: font))),
    ]);
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);
    await OpenDocument.openDocument(filePath: filePath);
  }

String getSubTotal(List<Item> products) {
  return products
      .fold(0.0,
          (double prev, element) => prev + (element.amount * element.price!))
      .toStringAsFixed(2);
}

// String getVatTotal(List<Item> products) {
//   return products
//       .fold(
//         0.0,
//         (double prev, next) =>
//             prev + ((next.price / 100 * next.vatInPercent) * next.amount),
//       )
//       .toStringAsFixed(2);
// }
}
