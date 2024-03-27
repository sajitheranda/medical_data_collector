import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/firebaseStore/GetPatient.dart';
import 'package:medicalapp1/properties/Appcolor.dart';

import '../charts/BarChartDraw.dart';
import '../charts/PieChartDraw.dart';
import '../components/AnimatedCountWidget.dart';
import '../components/ChartWithDataEntry.dart';
import '../components/MyAppBarHome.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CollctionStatus extends StatefulWidget {
  const CollctionStatus({super.key});

  @override
  State<CollctionStatus> createState() => _CollctionStatusState();
}

class _CollctionStatusState extends State<CollctionStatus> {
  GetPatient getPatient= GetPatient();

  final chartColors = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.yellow[900],
    Colors.purple,
    Colors.orange[900],
    Colors.teal,
    Colors.indigo,
  ];


  Future<void> initiateData() async {
    await getPatient.initiate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHome("Collection Status"),
      body: FutureBuilder<void>(
        future: initiateData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while fetching data
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    CircularProgressIndicator(),
                    SizedBox(height:10.0),
                    Text("Waiting",style: TextStyle(color: Appcolor.mainColor),)
                  ]
              ),
            );
          } else if (snapshot.hasError) {
            // Handle errors
            return Text('Error: ${snapshot.error}');
          } else {
            // Data is ready, build your UI
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: [
                  ShowCard("Toatal patients",getPatient.totalCountPatient.toString()),
                  if (getPatient.totalCountPatient != 0 ) PieChartDraw("Gender Percentages",getPatient.genderCount) else Text(""),
                  if (getPatient.totalCountPatient != 0 ) PieChartDraw("Area Type Percentages",getPatient.AreatypeList) else Text(""),
                  if (getPatient.totalCountPatient != 0 ) BarChartDraw("Area Type Percentages",getPatient.AreatypeList) else Text(""),
                  if (getPatient.totalCountPatient != 0 ) PieChartDraw("Guardian of house",getPatient.guardianList) else Text(""),
                  if (getPatient.totalCountPatient != 0 ) BarChartDraw("Activity Status",getPatient.ActivityStatusList),
                  if (getPatient.totalCountPatient != 0 ) BarChartDraw("Vehicle type",getPatient.VehicalTypeList),


                  // Other widgets...
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget ShowCard(String title,String value){
    return  Card(
      color: Appcolor.mainColor,
      margin: EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text(
              "${title}  = ",
              style: TextStyle(
                color: Colors.yellow[800],
                fontSize: 20.0,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
    );

  }

}
