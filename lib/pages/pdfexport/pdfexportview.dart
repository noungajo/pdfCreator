import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import '../../model/invoicemodel.dart';
import 'pdf/pdfexport.dart';

/*
Interface de prévisualisation du pdf. Elle prend en paramètre ou bien d'un controller une facture et la prévisualise
*/
class PdfPreviewPage extends StatelessWidget {
  final Invoice invoice;
  const PdfPreviewPage({Key? key, required this.invoice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyyMMdd');
    final String date = formatter.format(now);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Reçu de paiement',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: PdfPreview(
        pdfFileName: date + "Andaal_reçu.pdf",
        build: (context) => makePdf(),
      ),
    );
  }
}
