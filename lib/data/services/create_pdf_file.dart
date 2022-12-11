import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CreatePdfFile {
  Future<void> createWorkReportPdf() async {
    PdfDocument pdfdoc = PdfDocument();
    final page = pdfdoc.pages.add();

    page.graphics.drawString(
      "Work Report of Site : ${DateFormat.MMMd().format(DateTime.now())}",
      PdfStandardFont(PdfFontFamily.helvetica, 30),
    );

    List<int> bytes = await pdfdoc.save();
    saveandLaunchPdfFile(bytes, "Output.pdf");
    pdfdoc.dispose();
  }

  Future<void> saveandLaunchPdfFile(List<int> bytes, String filename) async {
    final path = (await getExternalStorageDirectory())!.path;
    final XFile file = XFile("$path/$filename");
    OpenFilex.open(file.path);
  }
}
