import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

class MakeStockReportPdf {
  Widget paddedText(
    final String text,
    final PdfColor color, {
    final TextAlign align = TextAlign.left,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Text(
          text,
          textAlign: align,
          style: TextStyle(
            fontSize: 12,
            color: color,
            fontWeight: FontWeight.normal,
          ),
        ),
      );

  Future<Uint8List> makePdf(List<Map<String, dynamic>> data) async {
    final imageLogo = MemoryImage(
        (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List());
    final pdf = Document();
    pdf.addPage(
      MultiPage(
        build: (context) {
          return <Widget>[
            Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              color: PdfColor.fromHex("262262"),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Daily Stocks Report",
                    style: TextStyle(
                      fontSize: 15,
                      color: PdfColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Date : ${DateFormat.yMMMMd().format(DateTime.now())}",
                    style: TextStyle(
                        fontSize: 15,
                        color: PdfColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Aakar Developers",
                      style: TextStyle(
                          fontSize: 15,
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Kapan, Kathmandu",
                      style: TextStyle(
                          fontSize: 15,
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sitename : ${data[0]['sitename']}",
                      style: TextStyle(
                          fontSize: 15,
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 75,
                  width: 75,
                  child: Image(
                    imageLogo,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Table(
              border: TableBorder.symmetric(
                  outside: const BorderSide(
                    color: PdfColors.black,
                  ),
                  inside: const BorderSide(color: PdfColors.grey)),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("262262")),
                  children: [
                    paddedText("SN", PdfColor.fromHex("F5F5F5")),
                    paddedText("Title", PdfColor.fromHex("F5F5F5")),
                    paddedText("Brand Name", PdfColor.fromHex("F5F5F5")),
                    paddedText("Supplier Name", PdfColor.fromHex("F5F5F5")),
                    paddedText("Stocks", PdfColor.fromHex("F5F5F5")),
                    paddedText("Unit", PdfColor.fromHex("F5F5F5")),
                  ],
                ),
                ...data.map(
                  (e) {
                    return TableRow(
                      children: <Widget>[
                        paddedText(e['sn'], PdfColors.black),
                        paddedText(e['itemname'], PdfColors.black),
                        paddedText(e['brandname'], PdfColors.black),
                        paddedText(e['suppliername'], PdfColors.black),
                        paddedText("${e['quantity']}", PdfColors.black),
                        paddedText(e['unit'], PdfColors.black),
                      ],
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 45),
            Align(
              alignment: Alignment.bottomRight,
              child: Column(
                children: [
                  SizedBox(
                    width: 155,
                    child: Divider(
                      color: PdfColors.black,
                    ),
                  ),
                  Text(
                    "Supervisor Signature",
                    style: TextStyle(
                        fontSize: 15,
                        color: PdfColors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
    return pdf.save();
  }
}
