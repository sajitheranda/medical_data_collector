import 'dart:io';
import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfGeneration{

  Future<pw.Document> generateInvoicePdf() async {
    final pdf = pw.Document();
    print("starting pdf...");


    List<InvoiceItem> items = [
      InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
      InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),
      InvoiceItem(name: "Item 3", quantity: 1, price: 20.0),
    ];

    pdf.addPage(
      Page(
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          return Center(
            child: Text('Hello World'),
          ); // Center
        },
      ), // Page
    );

    // pdf.addPage(
    //
    //   pw.Page(
    //     build: (context) {
    //
    //       return pw.Center(
    //         child: pw.Column(
    //           children: [
    //             pw.Text('Invoice'),
    //             // for (var item in items)
    //             //   pw.Row(
    //             //     mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
    //             //     children: [
    //             //       pw.Text(item.name),
    //             //       pw.Text('${item.quantity} x \$${item.price}'),
    //             //     ],
    //             //   ),
    //             // pw.SizedBox(height: 20),
    //             // pw.Text('Total: \$${calculateTotal(items)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
    print("middel working..");

    final file = File('invoice.pdf');
    await file.writeAsBytes(await pdf.save());
    print("ending pdf...");

    return pdf;
  }

  double calculateTotal(List<InvoiceItem> items) {
    return items.fold(0, (total, item) => total + (item.quantity * item.price));
  }

  Future<Uint8List> buildPdf(PdfPageFormat format) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();

    List<InvoiceItem> items = [
      InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
      InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),
      InvoiceItem(name: "Item 3", quantity: 1, price: 20.0),
      InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
      InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),
      InvoiceItem(name: "Item 3", quantity: 1, price: 20.0),
      InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
      InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),
      InvoiceItem(name: "Item 3", quantity: 1, price: 20.0),
      InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
      InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),
      InvoiceItem(name: "Item 3", quantity: 1, price: 20.0),
      InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
      InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),
      InvoiceItem(name: "Item 3", quantity: 1, price: 20.0),
      InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
      InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),
      InvoiceItem(name: "Item 3", quantity: 1, price: 20.0),
      InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
      InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),

    ];

    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.ConstrainedBox(
            constraints: pw.BoxConstraints.expand(),
            child: pw.FittedBox(
              child : pw.Column(
                 //mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   pw.Text('Hello World',style:pw.TextStyle(fontSize: 5)),
                   for (var item in items)
                       pw.Row(
                         mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                         children: [
                           pw.Text(item.name,style:pw.TextStyle(fontSize: 5)),
                           pw.Text('${item.quantity} x \$${item.price}',style:pw.TextStyle(fontSize: 5)),
                         ],
                       ),
                     pw.SizedBox(height: 20),
                     pw.Text('Total: \$${calculateTotal(items)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold,fontSize: 1)),
                 ]

              )

            ),
          );
        },
      ),
    );
    print("working");

    // Build and return the final Pdf file data
    return await doc.save();

   }



}

class InvoiceItem {
  final String name;
  final int quantity;
  final double price;

  InvoiceItem({required this.name, required this.quantity, required this.price});
}

// Sample data for invoice items
