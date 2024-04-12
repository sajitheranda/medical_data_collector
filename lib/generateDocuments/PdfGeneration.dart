import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicalapp1/attribute/PatientData.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

import '../class/Child.dart';
import '../class/WeightHeight.dart';

class PdfGeneration{



  // Future<Uint8List> createPdfAllChild(PdfPageFormat format , List<DocumentSnapshot> DocumentList) async {
  //   // Create the Pdf document
  //   final pw.Document doc = pw.Document();
  //   final Uint8List imageCompany = (await rootBundle.load("assets/icons/iconnew.jpg")).buffer.asUint8List();
  //   //print("image = "+imageCompany.toString());
  //
  //   // List<InvoiceItem> items = [
  //   //   InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
  //   //   InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),
  //   //   InvoiceItem(name: "Item 3", quantity: 1, price: 20.0),
  //   //   InvoiceItem(name: "Item 1", quantity: 2, price: 10.0),
  //   //   InvoiceItem(name: "Item 2", quantity: 3, price: 15.0),
  //   //   InvoiceItem(name: "Item 3", quantity: 1, price: 20.0),
  //   //
  //   // ];
  //   List<List<String>> items= convertToDynamicListAllData(DocumentList);
  //
  //
  //   // Add one page with centered text "Hello World"
  //   final int maxItemsPerPage = 30;
  //
  //   // Calculate the number of pages needed
  //   final int pageCount = (items.length / maxItemsPerPage).ceil();
  //
  //   /////////////
  //   final currentDate = DateTime.now();
  //   final formattedDate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
  //   final formattedTime = "${currentDate.hour}:${currentDate.minute}:${currentDate.second}";
  //
  //
  //   // Add pages
  //   for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
  //     final startIndex = pageIndex * maxItemsPerPage;
  //     final endIndex = (pageIndex + 1) * maxItemsPerPage;
  //
  //     final pageItems = items.sublist(
  //         startIndex, endIndex > items.length ? items.length : endIndex);
  //
  //     // Add one page with centered text "Hello World"
  //     doc.addPage(
  //       pw.Page(
  //         pageFormat: format,
  //         build: (pw.Context context) {
  //           return pw.ConstrainedBox(
  //             constraints: pw.BoxConstraints.tightForFinite(),
  //             //constraints: pw.BoxConstraints.expand(),
  //             child: pw.Padding(
  //               padding: pw.EdgeInsets.all(20),
  //               child:  pw.Column(
  //                 crossAxisAlignment: pw.CrossAxisAlignment.center,
  //                 mainAxisAlignment: pw.MainAxisAlignment.start,
  //                 children: [
  //                   pw.Row(
  //                     mainAxisAlignment: pw.MainAxisAlignment.center,
  //                     children: [
  //                       pw.Image(pw.MemoryImage(imageCompany),height: 30.0, width: 30.0),
  //                       pw.SizedBox(
  //                         width: 20.0,
  //                       ),
  //                       pw.Text('PREmal', style: pw.TextStyle(
  //                           fontSize: 25, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
  //                     ]
  //                   ),
  //                   pw.Row(
  //                       mainAxisAlignment: pw.MainAxisAlignment.center,
  //                       children: [
  //                         pw.Text('Child Details ', style: pw.TextStyle(
  //                             fontSize: 20, fontWeight: pw.FontWeight.bold)),
  //                         pw.Text('All Areas', style: pw.TextStyle(
  //                             fontSize: 20, fontWeight: pw.FontWeight.bold , color: PdfColors.green)),
  //                       ]
  //                   ),
  //
  //
  //                   pw.SizedBox(
  //                     height: 20.0,
  //                   ),
  //                   pw.Table.fromTextArray(
  //                     context: context,
  //                     data:  pageItems,
  //                     border: pw.TableBorder.all(
  //                         width: 1, color: PdfColors.grey),
  //                     cellPadding: pw.EdgeInsets.all(5),
  //                     cellAlignment: pw.Alignment.center,
  //                     cellStyle: pw.TextStyle(fontSize: 10),
  //                     headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
  //                     headerDecoration: pw.BoxDecoration(
  //                         color: PdfColors.blue400),
  //                     headerAlignment: pw.Alignment.center,
  //                     // Apply background color to cells based on row index
  //                     cellDecoration: (index, data, rowNum) {
  //                       if(rowNum.isEven){
  //                         return pw.BoxDecoration(color: PdfColors.blue100);
  //                       }else{
  //                         return pw.BoxDecoration(color: PdfColors.white);
  //                       }
  //                     },
  //
  //                   ),
  //                   pw.SizedBox(height: 30),
  //
  //                   pw.Row(
  //                       mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
  //                       children: [
  //                         pw.Text("Date: $formattedDate Time: $formattedTime", style: pw.TextStyle(fontSize: 10)),
  //                         pw.Text('Page ${context.pageNumber} of $pageCount', style: pw.TextStyle(fontSize: 10)),
  //                       ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //
  //
  //           );
  //         },
  //       ),
  //     );
  //   }
  //   print("working");
  //
  //   // Build and return the final Pdf file data
  //   return await doc.save();
  //
  // }



  List<List<String>> convertToDynamicListAllData(List<DocumentSnapshot<Object?>> documentList) {
    List<List<String>> resultList = [];
    resultList.add(PatientData.childWordingpdf);


    for (DocumentSnapshot? document in documentList) {

        Child child = Child(document); // Assuming Child is a class that takes DocumentSnapshot
        List<String> childData = child.dataAllPdf(); // Assuming dataAll() returns a List<dynamic>
        resultList.add(childData);
    }

    //print(resultList);

    return resultList;

  }

  Future<Uint8List> createPdfTypeChild(PdfPageFormat format , List<DocumentSnapshot> DocumentList,String areaType) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();
    final Uint8List imageCompany = (await rootBundle.load("assets/icons/iconnew.jpg")).buffer.asUint8List();

    List<List<String>> items= List.empty();

    if(areaType =="All"){
      items= convertToDynamicListAllData(DocumentList);
    }else{
      items= convertToDynamicListTypeData(DocumentList);
    }


    // Add one page with centered text "Hello World"
    final int maxItemsPerPage = 20;

    // Calculate the number of pages needed
    final int pageCount = (items.length / maxItemsPerPage).ceil();

    /////////////
    final currentDate = DateTime.now();
    final formattedDate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
    final formattedTime = "${currentDate.hour}:${currentDate.minute}:${currentDate.second}";


    // Add pages
    for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
      final startIndex = pageIndex * maxItemsPerPage;
      final endIndex = (pageIndex + 1) * maxItemsPerPage;

      final pageItems = items.sublist(
          startIndex, endIndex > items.length ? items.length : endIndex);

      // Add one page with centered text "Hello World"
      doc.addPage(
        pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.ConstrainedBox(
              constraints: pw.BoxConstraints.tightForFinite(),
              //constraints: pw.BoxConstraints.expand(),
              child: pw.Padding(
                padding: pw.EdgeInsets.all(20),
                child:  pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Image(pw.MemoryImage(imageCompany),height: 30.0, width: 30.0),
                          pw.SizedBox(
                            width: 20.0,
                          ),
                          pw.Text('PREmal', style: pw.TextStyle(
                              fontSize: 25, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                        ]
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Child Details ', style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                          pw.Text('${areaType} Areas', style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold , color: PdfColors.green)),
                        ]
                    ),


                    pw.SizedBox(
                      height: 20.0,
                    ),
                    pw.Table.fromTextArray(
                      context: context,
                      data:  pageItems,
                      border: pw.TableBorder.all(
                          width: 1, color: PdfColors.grey),
                      cellPadding: pw.EdgeInsets.all(5),
                      cellAlignment: pw.Alignment.center,
                      cellStyle: pw.TextStyle(fontSize: 10),
                      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      headerDecoration: pw.BoxDecoration(
                          color: PdfColors.blue400),
                      headerAlignment: pw.Alignment.center,
                      // Apply background color to cells based on row index
                      cellDecoration: (index, data, rowNum) {
                        if(rowNum.isEven){
                          return pw.BoxDecoration(color: PdfColors.blue100);
                        }else{
                          return pw.BoxDecoration(color: PdfColors.white);
                        }
                      },

                    ),
                    pw.SizedBox(height: 30),

                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text("Date: $formattedDate Time: $formattedTime", style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Page ${context.pageNumber} of $pageCount', style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),


            );
          },
        ),
      );
    }
    print("working");

    // Build and return the final Pdf file data
    return await doc.save();

  }

  List<List<String>> convertToDynamicListTypeData(List<DocumentSnapshot<Object?>> documentList) {
    List<List<String>> resultList = [];
    resultList.add(PatientData.childWordingpdfWithoutArea);


    for (DocumentSnapshot? document in documentList) {

      Child child = Child(document); // Assuming Child is a class that takes DocumentSnapshot
      List<String> childData = child.dataAllPdfWithoutArea(); // Assuming dataAll() returns a List<dynamic>
      resultList.add(childData);
    }

    //print(resultList);

    return resultList;

  }


  Future<Uint8List> createPdfOneChild(PdfPageFormat format , DocumentSnapshot? DocumentList,List<WeightHeight> weightheightData) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();
    final Uint8List imageCompany = (await rootBundle.load("assets/icons/iconnew.jpg")).buffer.asUint8List();

    List<pw.Widget> items= convertToDynamicListForOneChild(DocumentList!);

    // Add one page with centered text "Hello World"
    int maxItemsPerPage = 15;
    int maxItemsPerPageTable = 25;

    // Calculate the number of pages needed
    int pageCount = (items.length / maxItemsPerPage).ceil();
    int page1Count = (items.length / maxItemsPerPage).ceil();
    int totalPageCount =(items.length / maxItemsPerPage).ceil() + (weightheightData.length /maxItemsPerPageTable).ceil();

    /////////////
    final currentDate = DateTime.now();
    final formattedDate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
    final formattedTime = "${currentDate.hour}:${currentDate.minute}:${currentDate.second}";


    // Add pages
    for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
      final startIndex = pageIndex * maxItemsPerPage;
      final endIndex = (pageIndex + 1) * maxItemsPerPage;

      final pageItems = items.sublist(
          startIndex, endIndex > items.length ? items.length : endIndex);


      // Add one page with centered text "Hello World"
      doc.addPage(
        pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.ConstrainedBox(
              constraints: pw.BoxConstraints.expand(),
              //constraints: pw.BoxConstraints.expand(),
              child: pw.Padding(
                padding: pw.EdgeInsets.all(20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Image(pw.MemoryImage(imageCompany), height: 30.0,
                              width: 30.0),
                          pw.SizedBox(
                            width: 20.0,
                          ),
                          pw.Text('PREmal', style: pw.TextStyle(
                              fontSize: 25,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue900)),
                        ]
                    ),
                    pw.SizedBox(
                      height: 10.0,
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Child Details ', style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                        ]
                    ),

                    pw.SizedBox(
                      height: 20.0,
                    ),
                    for( var widgetitem in pageItems)
                      widgetitem,

                    pw.SizedBox(height: 30),

                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text("Date: $formattedDate Time: $formattedTime",
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Page ${context.pageNumber} of $totalPageCount',
                            style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),


            );
          },
        ),
      );
    }
    pageCount = (weightheightData.length /maxItemsPerPageTable).ceil();


    // Add pages
    for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
      final startIndex = pageIndex * maxItemsPerPageTable;
      final endIndex = (pageIndex + 1) * maxItemsPerPageTable;

      final pageItems = weightheightData.sublist(
          startIndex, endIndex > weightheightData.length ? weightheightData.length : endIndex);

      // Add one page with centered text "Hello World"
      doc.addPage(
        pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.ConstrainedBox(
              constraints: pw.BoxConstraints.tightForFinite(),
              //constraints: pw.BoxConstraints.expand(),
              child: pw.Padding(
                padding: pw.EdgeInsets.all(20),
                child:  pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Image(pw.MemoryImage(imageCompany),height: 30.0, width: 30.0),
                          pw.SizedBox(
                            width: 20.0,
                          ),
                          pw.Text('PREmal', style: pw.TextStyle(
                              fontSize: 25, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                        ]
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Child Details ', style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                          pw.Text('Weight Height', style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold , color: PdfColors.green)),
                        ]
                    ),


                    pw.SizedBox(
                      height: 20.0,
                    ),
                    pw.Table.fromTextArray(
                      context: context,
                      data: <List<dynamic>>[
                        // Header row
                        ['Month', 'Weight', 'Height'],
                        // Dynamically create rows for each item
                        for (WeightHeight item in pageItems)
                          [item.month, item.weight, item.height],
                      ],
                      border: pw.TableBorder.all(
                          width: 1, color: PdfColors.grey),
                      cellPadding: pw.EdgeInsets.all(5),
                      cellAlignment: pw.Alignment.center,
                      cellStyle: pw.TextStyle(fontSize: 10),
                      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      headerDecoration: pw.BoxDecoration(
                          color: PdfColors.blue400),
                      headerAlignment: pw.Alignment.center,
                      // Apply background color to cells based on row index
                      cellDecoration: (index, data, rowNum) {
                        if(rowNum.isEven){
                          return pw.BoxDecoration(color: PdfColors.blue100);
                        }else{
                          return pw.BoxDecoration(color: PdfColors.white);
                        }
                      },

                    ),
                    pw.SizedBox(height: 30),

                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text("Date: $formattedDate Time: $formattedTime", style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Page ${context.pageNumber} of $totalPageCount', style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),


            );
          },
        ),
      );
    }
    print("working");

    // Build and return the final Pdf file data
    return await doc.save();

  }

  Future<Uint8List> createPdfOneChildNew(PdfPageFormat format , DocumentSnapshot? DocumentList,List<WeightHeight> weightheightData) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();
    final Uint8List imageCompany = (await rootBundle.load("assets/icons/iconnew.jpg")).buffer.asUint8List();

    List<pw.Widget> items= convertToDynamicListForOneChild(DocumentList!);

    // Add one page with centered text "Hello World"
    int maxItemsPerPage = 15;
    int maxItemsPerPageTable = 25;

    // Calculate the number of pages needed
    int pageCount = (items.length / maxItemsPerPage).ceil();
    int page1Count = (items.length / maxItemsPerPage).ceil();
    int totalPageCount = 2 ;//(items.length / maxItemsPerPage).ceil() + (weightheightData.length /maxItemsPerPageTable).ceil();

    /////////////
    final currentDate = DateTime.now();
    final formattedDate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
    final formattedTime = "${currentDate.hour}:${currentDate.minute}:${currentDate.second}";


    // Add pages
    // for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
    //   final startIndex = pageIndex * maxItemsPerPage;
    //   final endIndex = (pageIndex + 1) * maxItemsPerPage;
    //
    //   final pageItems = items.sublist(
    //       startIndex, endIndex > items.length ? items.length : endIndex);

    // Add one page with centered text "Hello World"
      doc.addPage(
        pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return
              pw.ConstrainedBox(
              constraints: pw.BoxConstraints.tightForFinite(),
              //constraints: pw.BoxConstraints.expand(),
              child: pw.Padding(
                padding: pw.EdgeInsets.all(20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Image(pw.MemoryImage(imageCompany), height: 30.0,
                              width: 30.0),
                          pw.SizedBox(
                            width: 20.0,
                          ),
                          pw.Text('PREmal', style: pw.TextStyle(
                              fontSize: 25,
                              fontWeight: pw.FontWeight.bold,
                              color: PdfColors.blue900)),
                        ]
                    ),
                    pw.SizedBox(
                      height: 10.0,
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Child Details ', style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                        ]
                    ),

                    pw.SizedBox(
                      height: 20.0,
                    ),
                    for( var widgetitem in items)
                      widgetitem,
                    pw.SizedBox(height: 30),

                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text("Date: $formattedDate Time: $formattedTime",
                            style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Page ${context.pageNumber} of $totalPageCount',
                            style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),

            );
          },
        ),
      );
    //}
    pageCount = (weightheightData.length /maxItemsPerPageTable).ceil();


    // Add pages
    for (int pageIndex = 0; pageIndex < pageCount; pageIndex++) {
      final startIndex = pageIndex * maxItemsPerPageTable;
      final endIndex = (pageIndex + 1) * maxItemsPerPageTable;

      final pageItems = weightheightData.sublist(
          startIndex, endIndex > weightheightData.length ? weightheightData.length : endIndex);

      // Add one page with centered text "Hello World"
      doc.addPage(
        pw.Page(
          pageFormat: format,
          build: (pw.Context context) {
            return pw.ConstrainedBox(
              constraints: pw.BoxConstraints.expand(),
              //constraints: pw.BoxConstraints.expand(),
              child: pw.Padding(
                padding: pw.EdgeInsets.all(20),
                child:  pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Image(pw.MemoryImage(imageCompany),height: 30.0, width: 30.0),
                          pw.SizedBox(
                            width: 20.0,
                          ),
                          pw.Text('PREmal', style: pw.TextStyle(
                              fontSize: 25, fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                        ]
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text('Child Details ', style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold)),
                          pw.Text('Weight and Height', style: pw.TextStyle(
                              fontSize: 20, fontWeight: pw.FontWeight.bold , color: PdfColors.green)),
                        ]
                    ),


                    pw.SizedBox(
                      height: 20.0,
                    ),
                    pw.Table.fromTextArray(
                      context: context,
                      data: <List<dynamic>>[
                        // Header row
                        ['Month', 'Weight', 'Height'],
                        // Dynamically create rows for each item
                        for (WeightHeight item in pageItems)
                          [item.month, item.weight, item.height],
                      ],
                      border: pw.TableBorder.all(
                          width: 1, color: PdfColors.grey),
                      cellPadding: pw.EdgeInsets.all(5),
                      cellAlignment: pw.Alignment.center,
                      cellStyle: pw.TextStyle(fontSize: 8),
                      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      headerDecoration: pw.BoxDecoration(
                          color: PdfColors.blue400),
                      headerAlignment: pw.Alignment.center,
                      // Apply background color to cells based on row index
                      cellDecoration: (index, data, rowNum) {
                        if(rowNum.isEven){
                          return pw.BoxDecoration(color: PdfColors.blue100);
                        }else{
                          return pw.BoxDecoration(color: PdfColors.white);
                        }
                      },

                    ),
                    pw.SizedBox(height: 20),
                    showItemHighlight(PatientData.heightForAge, Child(DocumentList).heightForAge),
                    showItemHighlight(PatientData.weightForAge, Child(DocumentList).weightForAge),
                    showItemHighlight(PatientData.weightForHeight, Child(DocumentList).weightForHeight),
                    pw.SizedBox(height: 30),

                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                      children: [
                        pw.Text("Date: $formattedDate Time: $formattedTime", style: pw.TextStyle(fontSize: 10)),
                        pw.Text('Page ${context.pageNumber} of $totalPageCount', style: pw.TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),


            );
          },
        ),
      );
    }
    print("working");

    // Build and return the final Pdf file data
    return await doc.save();

  }

  List<pw.Widget> convertToDynamicListForOneChild(DocumentSnapshot<Object?> documentList) {
    List<pw.Widget> resultWidgets = [];
    Child child= Child(documentList);
    List<String> Wording=PatientData.childWordingOneChildPDF;
    for (int i = 0; i < Wording.length; i++){
      resultWidgets.add(showItem(Wording[i],child.dataAllOneChildPDF()[i]));
    }

    return resultWidgets;

  }

  pw.Widget showItem(String name, String value) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.blue), // Add border color as needed
          borderRadius: pw.BorderRadius.circular(5.0), // Adjust border radius as needed
          color: PdfColors.blue50, // Add background color as needed
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.all(2.0), // Adjust inner padding as needed
              child: pw.Text("$name = ", style: pw.TextStyle(fontSize: 8, color: PdfColors.blue800)),
            ),
            pw.Padding(
                padding: pw.EdgeInsets.all(2.0), // Adjust inner padding as needed
                child: pw.Text(value, style: pw.TextStyle(fontSize: 8)),
              ),
          ],
        ),
      ),
    );
  }

  pw.Widget showItemHighlight(String name, String value) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(color: PdfColors.green), // Add border color as needed
          borderRadius: pw.BorderRadius.circular(5.0), // Adjust border radius as needed
          color: PdfColors.green50, // Add background color as needed
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.start,
          children: [
            pw.Padding(
              padding: pw.EdgeInsets.all(5.0), // Adjust inner padding as needed
              child: pw.Text("$name = ", style: pw.TextStyle(fontSize: 12, color: PdfColors.green800 , fontWeight: pw.FontWeight.bold)),
            ),
            pw.Padding(
              padding: pw.EdgeInsets.all(5.0), // Adjust inner padding as needed
              child: pw.Text(value, style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }





}



// Sample data for invoice items
