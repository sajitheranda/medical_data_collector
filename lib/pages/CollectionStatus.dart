import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../components/AnimatedCountWidget.dart';
import '../components/ChartWithDataEntry.dart';
import '../components/MyAppBarHome.dart';

class CollctionStatus extends StatefulWidget {
  const CollctionStatus({super.key});

  @override
  State<CollctionStatus> createState() => _CollctionStatusState();
}

class _CollctionStatusState extends State<CollctionStatus> {
  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the orange line
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  // This will be used to draw the blue line
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarHome("Collection Status"),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    color: Colors.blue,
                    value: 40,
                    title: 'blue\n40%',
                    radius: 50,
                    titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
                  ),
                  PieChartSectionData(
                    color: Colors.red,
                    value: 30,
                    title: '30%',
                    radius: 50,
                    titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
                  ),
                  PieChartSectionData(
                    color: Colors.green,
                    value: 20,
                    title: 'green\n20%',
                    radius: 50,
                    titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
                  ),
                  PieChartSectionData(
                    color: Colors.yellow,
                    value: 10,
                    title: 'yello\n10%',
                    radius: 50,
                    titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
                  ),
                ],
                // borderData: FlBorderData(show: false),
                // sectionsSpace: 0,
                //centerSpaceRadius: 40, // Adjust center hole radius if needed

              ),
              //sectionsSpace: 0, // Adjust space between sections if needed

            ),
          ),
      Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.yellow),
            SizedBox(width: 8.0),
            AnimatedCountWidget(count: 20),
          ],
        ),
      ),
          drawlinechart(),



        ],
      ),

    );
  }


  Widget drawlinechart(){
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // The red line
            LineChartBarData(
              spots: dummyData1,
              isCurved: true,
              barWidth: 3,
              color: Colors.red,
            ),
            // The orange line
            LineChartBarData(
              spots: dummyData2,
              isCurved: true,
              barWidth: 3,
              color: Colors.red,
            ),
            // The blue line
            LineChartBarData(
              spots: dummyData3,
              isCurved: false,
              barWidth: 3,
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
