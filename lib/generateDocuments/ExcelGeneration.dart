import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelGeneration{

  Future<String> createExcelSheet() async {
    // final xcel.Workbook workbook = xcel.Workbook();
    // final xcel.Worksheet sheet = workbook.worksheets[0];
    //
    // // Add headers (optional)
    // sheet.getRangeByIndex(1, 1).setText("Title");
    // sheet.getRangeByIndex(1, 2).setText("Link");

    // Create a new Excel document.
    final Workbook workbook = new Workbook();
     //Accessing worksheet via index.
    final Worksheet sheet = workbook.worksheets[0];
     //Add Text.
    sheet.getRangeByName('A1').setText('Hello World');
     //Add Number
    sheet.getRangeByName('A3').setNumber(44);
     //Add DateTime
    sheet.getRangeByName('A5').setDateTime(DateTime(2020,12,12,1,10,20));
     // Save the document.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String filePath = '$dir/AddingTextNumberDateTime.xlsx';
    final File file = File(filePath);
    await file.writeAsBytes(bytes,flush: true);

    return filePath;




    // Show a message or navigate to another screen

  }
}