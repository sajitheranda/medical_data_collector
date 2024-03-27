import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../properties/Appcolor.dart';

class PieChartDraw extends StatelessWidget {
  late String title;
  late Map<String,int> dataDict;

  final chartColors = [
    Colors.green,
    Colors.red,
    Colors.blue[500],
    Colors.yellow[900],
    Colors.purple,
    Colors.orange[900],
    Colors.teal,
    Colors.pink,
  ];

  PieChartDraw(this.title,this.dataDict,{super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Container(
            padding: EdgeInsets.only(top:22,bottom: 10),
            child: Text( title ,style: TextStyle(color: Appcolor.mainColor, fontSize: 20.0,fontWeight: FontWeight.w500),)
        ),
        AspectRatio(
          aspectRatio: 1.5,
          child: PieChart(
            PieChartData(
                sections: generatePiechartSectionData(dataDict)
              // borderData: FlBorderData(show: false),
              // sectionsSpace: 0,
              //centerSpaceRadius: 40, // Adjust center hole radius if needed
            ),
            //sectionsSpace: 0, // Adjust space between sections if needed
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> generatePiechartSectionData(Map<String,int> dataDict){
    List<PieChartSectionData> sections = <PieChartSectionData>[];
    final totalValue = dataDict.values.reduce((a, b) => a + b);
    int randomNumber= Random().nextInt(101);

    // Iterate over the dictionary items and create PieChartSectionData
    for (var i = 0; i < dataDict.length; i++) {
      final label = dataDict.keys.elementAt(i);
      final value = dataDict[label];

      // Calculate percentage
      final percentage = (value! / totalValue) * 100;

      // Create PieChartSectionData
      final section = PieChartSectionData(
        color: chartColors[(randomNumber+i) % chartColors.length],
        value: value?.toDouble(),
        title: '$label\n${percentage.toStringAsFixed(1)}%',
        radius: 50,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );

      sections.add(section);
    }
    return sections;
  }
}
