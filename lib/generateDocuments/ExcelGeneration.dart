import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/attribute/PatientData.dart';
import 'package:medicalapp1/class/Child.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelGeneration{

  Future<String> createExcelSheetAllchild(List<DocumentSnapshot> DocumentList) async {
    final Workbook workbook = new Workbook();
    //Accessing worksheet via index.
    final Worksheet sheet = workbook.worksheets[0];// working with index

    int row=1;

    final currentDate = DateTime.now();
    final formattedDate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
    final formattedTime = "${currentDate.hour}:${currentDate.minute}:${currentDate.second}";

    sheet.getRangeByName('A1:D1').merge();
    final xcel.Style titleStyle = sheet.getRangeByName('A1').cellStyle;
    titleStyle.bold = true;
    titleStyle.fontSize = 14;
    sheet.getRangeByName('A1').setText("Premal Child Details");

    sheet.getRangeByName('F1:G1').merge();
    sheet.getRangeByName('I1:J1').merge();
    sheet.getRangeByName('F1').setText("Date: $formattedDate");
    sheet.getRangeByName('I1').setText("Time: $formattedTime");

    int columLength=PatientData.childWording.length;


    row+=2;
    for (int i = 0; i < columLength; i++){
      xcel.Style titleStyle = sheet.getRangeByIndex(row, i+1).cellStyle;
      titleStyle.bold = true;
      sheet.getRangeByIndex(row, i+1).setText(PatientData.childWording[i]);
    }

    for (DocumentSnapshot? document in DocumentList) {
      Child child= Child(document);
      List<String> childDetails = child.dataAll();
      row++;

      for (int column = 0; column < childDetails.length; column++){
        sheet.getRangeByIndex(row, column+1).setText(childDetails[column]);
      }

    }


    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String filePath = '$dir/child_details_all.xlsx';
    final File file = File(filePath);
    await file.writeAsBytes(bytes,flush: true);

    return filePath;

  }

  Future<String> createExcelSheetAreatypechild(String type,List<DocumentSnapshot> DocumentList) async {
    final Workbook workbook = new Workbook();
    //Accessing worksheet via index.
    final Worksheet sheet = workbook.worksheets[0];// working with index

    int row=1;

    final currentDate = DateTime.now();
    final formattedDate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
    final formattedTime = "${currentDate.hour}:${currentDate.minute}:${currentDate.second}";

    sheet.getRangeByName('A1:E1').merge();
    final xcel.Style titleStyle = sheet.getRangeByName('A1').cellStyle;
    titleStyle.bold = true;
    titleStyle.fontSize = 14;
    sheet.getRangeByName('A1').setText("Premal Child Details ${type} category");

    sheet.getRangeByName('F1:G1').merge();
    sheet.getRangeByName('I1:J1').merge();
    sheet.getRangeByName('F1').setText("Date: $formattedDate");
    sheet.getRangeByName('I1').setText("Time: $formattedTime");

    int columLength=PatientData.childWordingWithoutArea.length;


    row+=2;
    for (int i = 0; i < columLength; i++){
      xcel.Style titleStyle = sheet.getRangeByIndex(row, i+1).cellStyle;
      titleStyle.bold = true;
      sheet.getRangeByIndex(row, i+1).setText(PatientData.childWordingWithoutArea[i]);
    }

    for (DocumentSnapshot? document in DocumentList) {
      Child child= Child(document);
      List<String> childDetails = child.dataAll();
      row++;

      for (int column = 0; column < childDetails.length; column++){
        sheet.getRangeByIndex(row, column+1).setText(childDetails[column]);
      }

    }


    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String filePath = '$dir/child_details_${type}.xlsx';
    final File file = File(filePath);
    await file.writeAsBytes(bytes,flush: true);

    return filePath;

  }



  // Future<String> createExcelSheetDummy() async {
  //   // final xcel.Workbook workbook = xcel.Workbook();
  //   // final xcel.Worksheet sheet = workbook.worksheets[0];
  //   //
  //   // // Add headers (optional)
  //   // sheet.getRangeByIndex(1, 1).setText("Title");
  //   // sheet.getRangeByIndex(1, 2).setText("Link");
  //
  //   // Create a new Excel document.
  //   final Workbook workbook = new Workbook();
  //    //Accessing worksheet via index.
  //   final Worksheet sheet = workbook.worksheets[0];
  //    //Add Text.
  //   // sheet.getRangeByName('A1').setText('Hello World');
  //   //  //Add Number
  //   // sheet.getRangeByName('A3').setNumber(44);
  //   //  //Add DateTime
  //   // sheet.getRangeByName('A5').setDateTime(DateTime(2020,12,12,1,10,20));
  //    // Save the document.
  //   // Add title
  //   int row=1;
  //
  //
  //
  //   final currentDate = DateTime.now();
  //   final formattedDate = "${currentDate.year}-${currentDate.month}-${currentDate.day}";
  //   final formattedTime = "${currentDate.hour}:${currentDate.minute}:${currentDate.second}";
  //
  //   sheet.getRangeByName('A1:D1').merge();
  //   final xcel.Style titleStyle = sheet.getRangeByName('A1').cellStyle;
  //   titleStyle.bold = true;
  //   titleStyle.fontSize = 14;
  //   sheet.getRangeByName('A1').setText("Premal Child Details");
  //
  //   sheet.getRangeByName('F1:G1').merge();
  //   sheet.getRangeByName('I1:J1').merge();
  //   sheet.getRangeByName('F1').setText("Date: $formattedDate");
  //   sheet.getRangeByName('I1').setText("Time: $formattedTime");
  //
  //
  //   row+=2;
  //   sheet.getRangeByIndex(row, 1).setText("Title");
  //   sheet.getRangeByIndex(row, 2).setText("Link");
  //
  //   // Example student data (replace with your actual data)
  //   final List<Map<String, String>> studentData = [
  //     {"title1": "title1", "link": "link1"},
  //     {"title": "title2", "link": "link2"},
  //     // Add more student data here...
  //   ];
  //
  //   // Insert student data
  //   for (var i = 0; i < studentData.length; i++) {
  //     row++;
  //     final student = studentData[i];
  //     sheet.getRangeByIndex(row, 1).setText(student["title"]);
  //     sheet.getRangeByIndex(row, 2).setText(student["link"]);
  //   }
  //
  //
  //   final List<int> bytes = workbook.saveAsStream();
  //   workbook.dispose();
  //   final String dir = (await getApplicationDocumentsDirectory()).path;
  //   final String filePath = '$dir/AddingTextNumberDateTime.xlsx';
  //   final File file = File(filePath);
  //   await file.writeAsBytes(bytes,flush: true);
  //
  //   return filePath;
  //
  //   // Show a message or navigate to another screen
  //
  // }
}