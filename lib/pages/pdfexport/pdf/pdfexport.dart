import 'dart:typed_data';

import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

/*
ici est construit le pdf
*/
Future<Uint8List> makePdf() async {
  initializeDateFormatting('fr_FR');
  DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat.yMMMMEEEEd('fr_FR');

  String date = formatter.format(now);
  //création du document
  final pdf = Document();
  //image à ajouetr au pdf
  final imageLogo = MemoryImage(
      (await rootBundle.load('assets/logo1.png')).buffer.asUint8List());

  final tableHeaders = [
    'Description',
    'Quantité',
    'Prix Unit',
    'Total',
  ];

  final tableData = [
    ["Mathématique Sil", '1', '2000 XAF', '2000 XAF'],
    ['Biologie', '3', '3000 XAF', '9000 XAF'],
    ["Mathématique Sil", '1', '2000 XAF', '2000 XAF'],
    ['Biologie', '3', '3000 XAF', '9000 XAF'],
    ["Connaissance de la langue Anglaise", "3", "1000 XAF", "3000 XAF"],
    ["Formation à l'utilisation de word", "3", "500 XAF", "1500 XAF"]
  ];

  pdf.addPage(MultiPage(
      crossAxisAlignment: CrossAxisAlignment.center,
      build: (context) {
        return [
          //l'en têtede la page
          Row(
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Image(imageLogo),
              ),
              SizedBox(width: 1 * PdfPageFormat.mm),
              /*
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reçu',
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '',
                    style: const TextStyle(
                      fontSize: 15.0,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
              ),
              */
              Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Noutcha Ngapi J.',
                    style: TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '690000000',
                  ),
                  Text(
                    date,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          //ligne horizontale
          Divider(),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(
            'Reçu',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4 * PdfPageFormat.mm),
          // Texte si nécessaire
          Text(
            'Votre paiement a été effectué avec succès et a été reçu par Andaal.',
            // 'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2 * PdfPageFormat.mm),
          Text(
            '14000 XAF',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            // 'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5 * PdfPageFormat.mm),
          Divider(),
          Container(height: 5 * PdfPageFormat.mm),
          Text(
            'Détail du paiement',
            style: TextStyle(fontSize: 14, color: PdfColors.grey),
            // 'Dear John,\nLorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. Veritatis obcaecati tenetur iure eius earum ut molestias architecto voluptate aliquam nihil, eveniet aliquid culpa officia aut! Impedit sit sunt quaerat, odit, tenetur error',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 2 * PdfPageFormat.mm),
          //======================================= Tableau des services ================
          //génère le tableau dynamiquement. Il suffit de bien structurer les données d'en tête et de données
          Table.fromTextArray(
            headers: tableHeaders,
            data: tableData,
            border: null,
            headerStyle: TextStyle(fontWeight: FontWeight.bold),
            headerDecoration: const BoxDecoration(color: PdfColors.grey300),
            cellHeight: 30.0,
            cellAlignments: {
              0: Alignment.centerLeft,
              1: Alignment.centerRight,
              2: Alignment.centerRight,
              3: Alignment.centerRight,
            },
          ),
          //=============================================================================
          //============================ l'ensemble des totaux ==========================
          Divider(),
          Container(
            alignment: Alignment.centerRight,
            child: Row(
              children: [
                Spacer(flex: 6),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /*
                        Row(
                          children: [
                            
                            Expanded(
                              child: Text(
                                'Net total',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '\$ 464',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Vat 19.5 %',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              '\$ 90.48',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        */
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '14000 XAF',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2 * PdfPageFormat.mm),
                      Container(height: 1, color: PdfColors.grey400),
                      SizedBox(height: 0.5 * PdfPageFormat.mm),
                      Container(height: 1, color: PdfColors.grey400),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ];
      },
      //========================================================le pied de page=============================
      footer: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            SizedBox(height: 2 * PdfPageFormat.mm),
            Text(
              '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1 * PdfPageFormat.mm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Address: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'ACTIV SPACE, Douala, Boulevard de la liberté, - Immeuble TECNO',
                ),
              ],
            ),
            SizedBox(height: 1 * PdfPageFormat.mm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Email: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'contact@ofty.fr',
                ),
              ],
            ),
            SizedBox(height: 1 * PdfPageFormat.mm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Téléphone: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '(+237) 681806222',
                ),
              ],
            ),
          ],
        );
      }));
//=========================================================================================================

  //=================== l'envoie du mail ===================================
  // final Email send_email = Email(
  //   body: 'En pièce jointe la facture de Noutcha Jonathan',
  //   subject: 'reçu B101',
  //   recipients: ['noutcha.ofty@gmail.com'],
  //   // cc: ['example_cc@ex.com'],
  //   // bcc: ['example_bcc@ex.com'],
  //   attachmentPaths: ["/storage/emulated/0/Download/20220810Andaal.pdf"],
  //   isHTML: false,
  // );

  // await FlutterEmailSender.send(send_email);
  //================================================================
  return pdf.save();
}



// Widget PaddedText(
//   final String text, {
//   final TextAlign align = TextAlign.left,
// }) {
//   return Padding(
//     padding: EdgeInsets.all(10),
//     child: Text(
//       text,
//       textAlign: align,
//     ),
//   );
// }

/*
 Page(
      build: (context) {
        return Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //en tête
            
            Container(height: 20),
            Text("Nom: ${invoices["client"]["name"]}",
                textAlign: TextAlign.left),
            Text("Téléphone: ${invoices["client"]["tel"]}",
                textAlign: TextAlign.left),
            Text("Email: ${invoices["client"]["email"]}",
                textAlign: TextAlign.left),

            Container(height: 50),
            //Tableau qui contient les informations de la commande
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                //une ligne du tableau. à chaque enfant une cellule
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'DESIGNATION',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'PRIX UNIT',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'QTE',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'MONTANT',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),

                //on parcourt la liste des produit pour afficher chaque produit

                ...List.generate(invoices["items"].length, (index) {
                  print(invoices["items"][index]["designation"]);
                  return TableRow(
                    children: [
                      Expanded(
                        child:
                            PaddedText(invoices["items"][index]["designation"]),
                        flex: 2,
                      ),
                      Expanded(
                        child: PaddedText(
                            "${invoices["items"][index]['P.U.H.T']} XAF"),
                        flex: 1,
                      ),
                      Expanded(
                        child: PaddedText(
                            "${invoices["items"][index]['Qte']} XAF"),
                        flex: 1,
                      ),
                      Expanded(
                        child: PaddedText(
                            "${invoices["items"][index]['Total']} XAF"),
                        flex: 1,
                      )
                    ],
                  );
                }),
              ],
            ),
            Container(height: 50),
            Table(border: TableBorder.all(color: PdfColors.black), children: [
              TableRow(
                children: [
                  PaddedText('TAX', align: TextAlign.left),
                  PaddedText(
                      '${(invoice.totalCost() * 0.1).toStringAsFixed(2)} XAF'),
                ],
              ),
              TableRow(
                children: [
                  PaddedText('TOTAL', align: TextAlign.left),
                  PaddedText('${(43300 * 1.1).toStringAsFixed(2)} XAF')
                ],
              )
            ]),
            Text(
                "Please forward the below slip to your accounts payable department."),
            // Divider(
            //   height: 1,
            //   borderStyle: BorderStyle.dashed,
            // ),
            // Container(height: 50),
            // Padding(
            //   padding: EdgeInsets.all(30),
            //   child: Text(
            //     'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
            //     style: Theme.of(context).header3.copyWith(
            //           fontStyle: FontStyle.italic,
            //         ),
            //     textAlign: TextAlign.center,
            //   ),
            // )
          ],
        );
      },
    ),
*/
/*
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
                    Text("Attention to: ${invoice.customer}"),
                    Text(invoice.address),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image(imageLogo),
                )
              ],
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'INVOICE FOR PAYMENT',
                        style: Theme.of(context).header4,
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
                ...invoice.items.map(
                  (e) => TableRow(
                    children: [
                      Expanded(
                        child: PaddedText(e.description),
                        flex: 2,
                      ),
                      Expanded(
                        child: PaddedText("\$${e.cost}"),
                        flex: 1,
                      )
                    ],
                  ),
                ),
                TableRow(
                  children: [
                    PaddedText('TAX', align: TextAlign.right),
                    PaddedText(
                        '\$${(invoice.totalCost() * 0.1).toStringAsFixed(2)}'),
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText('TOTAL', align: TextAlign.right),
                    PaddedText(
                        '\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            Padding(
              child: Text(
                "THANK YOU FOR YOUR CUSTOM!",
                style: Theme.of(context).header2,
              ),
              padding: EdgeInsets.all(20),
            ),
            Text(
                "Please forward the below slip to your accounts payable department."),
            Divider(
              height: 1,
              borderStyle: BorderStyle.dashed,
            ),
            Container(height: 50),
            Table(
              border: TableBorder.all(color: PdfColors.black),
              children: [
                TableRow(
                  children: [
                    PaddedText('Account Number'),
                    PaddedText(
                      '1234 1234',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Account Name',
                    ),
                    PaddedText(
                      'ADAM FAMILY TRUST',
                    )
                  ],
                ),
                TableRow(
                  children: [
                    PaddedText(
                      'Total Amount to be Paid',
                    ),
                    PaddedText(
                        '\$${(invoice.totalCost() * 1.1).toStringAsFixed(2)}')
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Please ensure all cheques are payable to the ADAM FAMILY TRUST.',
                style: Theme.of(context).header3.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    ),
  );
*/
