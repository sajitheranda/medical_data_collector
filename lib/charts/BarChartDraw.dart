import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../properties/Appcolor.dart';

class BarChartDraw extends StatelessWidget {

  late String title;
  late Map<String,int> dataDict;
  List<String> DataKeys = [];
  List<int> DataValues = [];
  int randomNumber=0;

  final chartColors = [
    Colors.green[900],
    Colors.red,
    Colors.blue,
    Colors.yellow[900],
    Colors.purple,
    Colors.orange[900],
    Colors.teal,
    Colors.indigo,
  ];


  BarChartDraw(this.title,this.dataDict,{super.key});

  @override
  Widget build(BuildContext context) {
    randomNumber= Random().nextInt(101);
    DataKeys = [];
    DataValues = [];

    dataDict = Map.fromEntries(
        dataDict.entries.toList()
          ..sort((a, b) => b.value.compareTo(a.value))
    );


    dataDict.forEach((key, value) {
      DataKeys.add(key);
      DataValues.add(value);
    });

    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(top:22,bottom: 10),
            child: Text( title ,style: TextStyle(color: Appcolor.mainColor, fontSize: 20.0,fontWeight: FontWeight.w500),)
        ),
        SizedBox(
          height: 20.0,
        ),
        AspectRatio(
          aspectRatio: 1.5,
          child: BarChart(
            BarChartData(
              barTouchData: barTouchData,
              titlesData: titlesData(DataKeys),
              borderData: borderData,
              barGroups: barGroups(),
              gridData: const FlGridData(show: false),
              alignment: BarChartAlignment.spaceAround,
            ),
          ),
        ),
      ],
    );
  }


  BarTouchData get barTouchData => BarTouchData(
    enabled: false,
    touchTooltipData: BarTouchTooltipData(
      tooltipBgColor: Colors.transparent,
      tooltipPadding: EdgeInsets.zero,
      tooltipMargin: 8,
      getTooltipItem: (
          BarChartGroupData group,
          int groupIndex,
          BarChartRodData rod,
          int rodIndex,
          ) {
        return BarTooltipItem(
          rod.toY.round().toString(),
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    ),
  );

  Widget getTitles(double value, TitleMeta meta,{int key =0}) {
    final style = TextStyle(
      color: chartColors[(value.toInt()+randomNumber) % chartColors.length],
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;

    int length=dataDict.length;
    text=DataKeys[value.toInt() % length];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData titlesData(List<String> dataKeys) => FlTitlesData(
    show: true,
    bottomTitles: AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        reservedSize: 30,
        getTitlesWidget: getTitles,
      ),
    ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  FlBorderData get borderData => FlBorderData(
    show: false,
  );

  LinearGradient _barsGradient(Color color) => LinearGradient(
    colors: [
     color.withOpacity(0.9),
      color.withOpacity(0.4),
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  List<BarChartGroupData>  barGroups(){

    List<BarChartGroupData> barChartGroups=[];


    for(int i=0;i < DataValues.length; i++){
      barChartGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              width: 30,
              toY: DataValues[i].toDouble(),
              color: chartColors[(i+randomNumber) % chartColors.length] ,
            )
          ],
          showingTooltipIndicators: [0],
        )
      );
    }

    return barChartGroups;

  }



}
