import 'package:construction/utils/app_colors.dart';
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

  Future<Uint8List> makePdf(List<Map<String, dynamic>> data) async {
    final imageLogo = MemoryImage(
        (await rootBundle.load('assets/images/logo.png')).buffer.asUint8List());
    final pdf = Document();
    pdf.addPage(
      Page(
        build: (context) {
          return Column(
            children: [
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
                        "Date : ${DateFormat.yMMMMd().format(DateTime.now())}",
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
                    height: 110,
                    width: 110,
                    child: Image(
                      imageLogo,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Table(
                border: TableBorder.symmetric(
                    outside: const BorderSide(
                      color: PdfColors.black,
                    ),
                    inside: const BorderSide(color: PdfColors.grey)),
                children: [
                  TableRow(
                    decoration:
                        BoxDecoration(color: PdfColor.fromHex("262262")),
                    children: [
                      paddedText("SN", PdfColor.fromHex("F5F5F5")),
                      paddedText("Title", PdfColor.fromHex("F5F5F5")),
                      paddedText("Started At", PdfColor.fromHex("F5F5F5")),
                      paddedText("End Date", PdfColor.fromHex("F5F5F5")),
                      paddedText("Progress", PdfColor.fromHex("F5F5F5")),
                    ],
                  ),
                  ...data.map((e) {
                    return TableRow(
                      children: [
                        paddedText(e['sn'], PdfColors.black),
                        paddedText(e['title'], PdfColors.black),
                        paddedText(e['startdate'], PdfColors.black),
                        paddedText(e['endDate'], PdfColors.black),
                        paddedText("${e['progress']}", PdfColors.black),
                      ],
                    );
                  }),
                ],
              )
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
}
