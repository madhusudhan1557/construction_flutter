import 'package:construction/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:printing/printing.dart';

import '../../../services/work_report_pdf.dart';
import '../../../utils/app_colors.dart';
import '../../includes/appbar.dart';

class PdfReportPreviewPage extends StatelessWidget {
  const PdfReportPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final List<Map<String, dynamic>> data = ModalRoute.of(context)!
        .settings
        .arguments as List<Map<String, dynamic>>;
    return data.isEmpty
        ? const Scaffold()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(size.width, size.height / 90 * 8.5),
              child: CustomAppbar(
                title: "Works Report",
                bgcolor: AppColors.white,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ).customAppBar(),
            ),
            body: PdfPreview(
              shouldRepaint: true,
              allowPrinting: true,
              allowSharing: true,
              loadingWidget: customLoading(size),
              canChangeOrientation: false,
              dynamicLayout: true,
              pdfFileName:
                  "${data[0]['sitename']} - ${DateFormat.yMMMd().format(DateTime.now())}",
              build: (context) => MakeWorkReportPdf().makePdf(data),
            ),
          );
  }
}
