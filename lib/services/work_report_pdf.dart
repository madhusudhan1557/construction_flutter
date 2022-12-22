import 'dart:io';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class WorkReportPdfApi {
  static Future<File> generatePDF(
      {required String name,
      required List<Map<String, dynamic>> data,
      required ByteData signatureImage,
      required ByteData logo,
      required int count}) async {
    final PdfDocument pdfdoc = PdfDocument();
    final page = pdfdoc.pages.add();

    final PdfBitmap logoImage = PdfBitmap(logo.buffer.asUint8List());
    page.graphics.drawString(
      'Aakar Developers',
      PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(0, 0, 0, 0),
      brush: PdfSolidBrush(
        PdfColor(1, 0, 0),
      ),
    );

    page.graphics.drawString(
      'Daily Work Report',
      PdfStandardFont(
        PdfFontFamily.helvetica,
        14,
        style: PdfFontStyle.bold,
      ),
      bounds: const Rect.fromLTWH(0, 20, 0, 0),
      brush: PdfSolidBrush(
        PdfColor(1, 0, 0),
      ),
    );
    page.graphics.drawString(
      'Sitename : ${data[0]['sitename']}',
      PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(0, 40, 0, 0),
      brush: PdfSolidBrush(
        PdfColor(1, 0, 0),
      ),
    );

    page.graphics.drawString(
      'Date : ${DateFormat.yMMMd().format(DateTime.now())}',
      PdfStandardFont(PdfFontFamily.helvetica, 14, style: PdfFontStyle.bold),
      bounds: const Rect.fromLTWH(0, 60, 0, 0),
      brush: PdfSolidBrush(
        PdfColor(1, 0, 0),
      ),
    );

    page.graphics.drawImage(
        logoImage, Rect.fromLTWH(page.getClientSize().width - 85, 0, 80, 80));

    drawSignatureWithTable(data, page, signatureImage, logo, count);

    return saveFile(pdfdoc, name);
  }

  static Future<File> saveFile(PdfDocument pdfdoc, name) async {
    final path = await getApplicationDocumentsDirectory();
    final filename =
        "${path.path}/$name - ${DateFormat.yMMMd().format(DateTime.now())}.pdf";
    final File file = File(filename);
    file.writeAsBytes(await pdfdoc.save());
    pdfdoc.dispose();
    return file;
  }

  static void drawSignatureWithTable(List<Map<String, dynamic>> data,
      PdfPage page, ByteData signatureImage, ByteData logo, int count) {
    final pageSize = page.getClientSize();
    final PdfBitmap image = PdfBitmap(signatureImage.buffer.asUint8List());
    final grid = PdfGrid();
    grid.columns.add(count: count);
    final headerRow = grid.headers.add(1)[0];

    PdfLayoutFormat format = PdfLayoutFormat(
      breakType: PdfLayoutBreakType.fitColumnsToPage,
      layoutType: PdfLayoutType.paginate,
    );
    headerRow.style.backgroundBrush = PdfSolidBrush(PdfColor(38, 34, 98, 1));
    headerRow.cells[0].value = "SN";
    headerRow.cells[1].value = "Title";
    headerRow.cells[2].value = "Start Date";
    headerRow.cells[3].value = "End Date";
    headerRow.cells[4].value = "Progress";

    grid.applyBuiltInStyle(PdfGridBuiltInStyle.listTable1LightAccent5);
    grid.allowRowBreakingAcrossPages = true;
    headerRow.style.textBrush = PdfSolidBrush(PdfColor(255, 255, 255, 1));
    headerRow.style.font = PdfStandardFont(
      PdfFontFamily.helvetica,
      10,
      style: PdfFontStyle.bold,
    );

    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 5, left: 8, right: 8, top: 5);
    }
    for (Map<String, dynamic> element in data) {
      final row = grid.rows.add();

      row.style.font = PdfStandardFont(
        PdfFontFamily.helvetica,
        8,
        style: PdfFontStyle.regular,
      );
      row.cells[0].value = element['sn'];
      row.cells[1].value = element['title'];
      row.cells[2].value = element['startdate'];
      row.cells[3].value = element['endDate'];
      row.cells[4].value = "${element['progress']} %";

      for (int i = 0; i < row.cells.count; i++) {
        row.cells[i].style.cellPadding =
            PdfPaddings(bottom: 5, left: 8, right: 8, top: 5);
      }
    }

    PdfLayoutResult result = grid.draw(
      page: page,
      bounds: const Rect.fromLTWH(0, 105, 0, 0),
      format: format,
    ) as PdfLayoutResult;

    page.graphics.drawString(
        "Supervisor Signature",
        PdfStandardFont(
          PdfFontFamily.helvetica,
          12,
        ),
        format: PdfStringFormat(alignment: PdfTextAlignment.right),
        bounds: Rect.fromLTWH(
          pageSize.width - 145,
          result.bounds.bottom + 70,
          140,
          15,
        ));

    page.graphics.drawImage(
      image,
      Rect.fromLTWH(
        pageSize.width - 120,
        result.bounds.bottom + 20,
        120,
        40,
      ),
    );
  }
}
