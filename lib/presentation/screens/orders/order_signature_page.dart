import 'dart:ui';

import 'package:construction/main.dart';
import 'package:construction/services/order_invoice_pdf_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_filex/open_filex.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../utils/app_colors.dart';
import '../../includes/appbar.dart';

class OrderInvoiceSignaturePadPage extends StatefulWidget {
  const OrderInvoiceSignaturePadPage({super.key});

  @override
  State<OrderInvoiceSignaturePadPage> createState() =>
      _OrderInvoiceSignaturePadPageState();
}

class _OrderInvoiceSignaturePadPageState
    extends State<OrderInvoiceSignaturePadPage> {
  final _key = GlobalKey<SfSignaturePadState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(size.width, size.height / 90 * 8.5),
        child: CustomAppbar(
          title: "Signature Pad",
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: padding.top * 0.4),
            alignment: Alignment.center,
            height: size.height / 2,
            width: size.width,
            color: AppColors.customWhite,
            child: SfSignaturePad(
              key: _key,
              backgroundColor: Colors.white,
              maximumStrokeWidth: 2.0,
              minimumStrokeWidth: 1.0,
            ),
          ),
          SizedBox(
            height: size.height / 90 * 3.44,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.yellow,
                  foregroundColor: AppColors.blue,
                  fixedSize: Size(size.width / 3, size.height / 90 * 3.44),
                ),
                onPressed: () {
                  onGeneratePdf(size, args);
                },
                child: const Text("Generate Report"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  foregroundColor: AppColors.white,
                  fixedSize: Size(size.width / 3, size.height / 90 * 3.44),
                ),
                onPressed: () => _key.currentState!.clear(),
                child: const Text("Retry"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future onGeneratePdf(Size size, args) async {
    showDialog(
      context: context,
      builder: (context) => customLoading(size),
    );
    final image = await _key.currentState!.toImage();
    final ByteData logo = await rootBundle.load("assets/images/logo.png");
    final signatureImage = await image.toByteData(format: ImageByteFormat.png);
    final file = await OrderInvoicePdfApi.generatePDF(
        name: args["name"],
        data: args['data'],
        signatureImage: signatureImage!,
        logo: logo,
        total: args['total'],
        count: args['count']);
    pop();
    await OpenFilex.open(file.path);
  }

  void pop() {
    Navigator.of(context).pop();
  }
}
