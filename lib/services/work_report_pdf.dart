import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';

class MakeWorkReportPdf {
  Widget paddedText(
    final String text,
    final PdfColor color, {
    final TextAlign align = TextAlign.left,
  }) =>
      Padding(
        padding: const EdgeInsets.all(10),
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

  Widget header() => Container(
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
      );

  Widget footer() => Container(
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: PdfColor.fromHex("262262"),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "Aakar Developers Pvt.Ltd",
            style: TextStyle(
              fontSize: 15,
              color: PdfColors.white,
              fontWeight: FontWeight.bold,
            ),
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
                    "Daily Works Report",
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
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Aakar Developers",
                      style: TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Kapan, Kathmandu",
                      style: TextStyle(
                          fontSize: 14,
                          color: PdfColors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sitename : ${data[0]['sitename']}",
                      style: TextStyle(
                          fontSize: 14,
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
                    paddedText("Started At", PdfColor.fromHex("F5F5F5")),
                    paddedText("End Date", PdfColor.fromHex("F5F5F5")),
                    paddedText("Progress", PdfColor.fromHex("F5F5F5")),
                  ],
                ),
                ...data.map(
                  (e) {
                    return TableRow(
                      children: <Widget>[
                        paddedText(e['sn'], PdfColors.black),
                        paddedText(e['title'], PdfColors.black),
                        paddedText(e['startdate'], PdfColors.black),
                        paddedText(e['endDate'], PdfColors.black),
                        paddedText("${e['progress']}", PdfColors.black),
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
