import 'package:construction/services/order_invoice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../../../main.dart';

import '../../../utils/app_colors.dart';
import '../../includes/appbar.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

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
                title: "Order Invoice",
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
                  "${data[0]['sitename']} Orders Invoice - ${DateFormat.yMMMd().format(DateTime.now())}",
              build: (context) => MakeOrderInvoiceReportPdf().makePdf(data),
            ),
          );
  }
}
