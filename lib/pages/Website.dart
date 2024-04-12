import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/generateDocuments/PdfGeneration.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../generateDocuments/ExcelGeneration.dart';

class Website extends StatefulWidget {
  const Website({super.key});

  @override
  State<Website> createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {


  Future<List<DocumentSnapshot>> getAllPatientData() async{

    var firestore = FirebaseFirestore.instance;
    QuerySnapshot query = await firestore.collection("patient")
        .where("isDelete", isEqualTo: 0) // Filter by Delete = 0
        .orderBy("timestamp", descending: true)
        .get();
    return query.docs;

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.car_crash),),
              Tab(icon: Icon(Icons.train_outlined),),
              Tab(icon: Icon(Icons.bus_alert),)
            ],
          ),
        ),
        body:Center(
          child:  Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.blue), ),
                child: Row(
                  children: [
      
                    Icon(
                      Icons.picture_as_pdf_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                    Text("PDF Generation"),
                  ],
                ),
                onPressed: () async {

                },
              ),
      
      
              ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.blue), ),
                child: Row(
                  children: [
                    Icon(
                      Icons.file_copy,
                      color: Colors.green,
                      size: 30,
                    ),
                    Text("Excel Generation"),
                  ],
                ),
                onPressed: () async {
                  List<DocumentSnapshot> DocumentList= await getAllPatientData();
                  String filePath=await ExcelGeneration().createExcelSheetAllchild(DocumentList);
                  print(filePath);
      
                  // final result = await Share.shareXFiles([XFile(filePath)], text: 'Excel sheet');
                  //
                  // if (result.status == ShareResultStatus.success) {
                  //   print('Thank you for downloading sheet');
                  // }
                  try {
                    //final file = XFile(filePath);
                    final result = await OpenFile.open(filePath);
                    print(result.message);
                  } catch (e) {
                    print('Error opening file: $e');
                  }
                  const snackBar = SnackBar(
                    content: Text('Excel sheet generation'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
      
      
      
      
            ],
          ),
      
      
      
        ),
      ),
    );
  }
}
