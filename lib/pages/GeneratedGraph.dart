import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/components/MyAppBarBack.dart';

import '../attribute/GirlWeightHeightLocalData.dart';
import '../attribute/BoyWeightHeightLocalData.dart';
import '../class/WeightHeight.dart';

class GeneratedGraph extends StatelessWidget {
  final List<WeightHeight> weightheightData;
  final String gender;

  const GeneratedGraph(this.weightheightData,this.gender,{super.key});



  @override
  Widget build(BuildContext context) {

    // final List<FlSpot> dummyData1 = List.generate(GirlWeightHeightLocalData.over_height.length, (index) {
    //   return FlSpot(index.toDouble(), GirlWeightHeightLocalData.over_height[index]);
    // });
    //
    // final List<FlSpot> dummy_height = List.generate(41, (index) {
    //   return FlSpot(index.toDouble(), 45+ Random().nextDouble()*10);
    // });
    bool isboy = gender == 'Male' ? true:false;

    final List<FlSpot> height_data = List.generate(
      weightheightData.length,
          (index) => FlSpot(
        weightheightData[index].month.toDouble(),
        weightheightData[index].height,
      ),
    );

     // Sort the height_data list based on the first value of each FlSpot object (x value)
    height_data.sort((a, b) => a.x.compareTo(b.x));

    final List<FlSpot> weight_data = List.generate(
      weightheightData.length,
          (index) => FlSpot(
        weightheightData[index].month.toDouble(),
        weightheightData[index].weight,
      ),
    );

    // Sort the height_data list based on the first value of each FlSpot object (x value)
    weight_data.sort((a, b) => a.x.compareTo(b.x));

    final List<FlSpot> weight_height_data = List.generate(
      weightheightData.length,
          (index) => FlSpot(
        weightheightData[index].height,
        weightheightData[index].weight,
      ),
    );

    // Sort the height_data list based on the first value of each FlSpot object (x value)
    weight_height_data.sort((a, b) => a.x.compareTo(b.x));



    return Scaffold(
      appBar: MyAppBarBack("Generaded Graphs"),
      body: Padding(
        padding:EdgeInsets.all(10),
        child: ListView(
          children: [
            getTitle("Height-Age chart",),
            drawHeightMonthChart(height_data,isboy),

            getTitle("Weight-Age chart",),
            drawWeightMonthChart(weight_data,isboy),

            getTitle("Weight-Height chart",),
            drawHeightWeightChart(weight_height_data,isboy)

          ],
        
        ),
      ),

    );
  }

  Widget getTitle(String title){
    return  Container(
      padding: EdgeInsets.only(top: 20.0,bottom: 10.0),
      alignment: Alignment.center,
      child: Text(title,style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
    );
  }

  Widget drawHeightWeightChart(sample_data,bool isboy){
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          //borderData: FlBorderData(show: false),
          lineBarsData: [
            // The red line
            LineBarDataget(isboy? BoyWeightHeightLocalData.over_weight_height : GirlWeightHeightLocalData.over_weight_height,Colors.pink),
            LineBarDataget(isboy? BoyWeightHeightLocalData.normal_weight_height : GirlWeightHeightLocalData.normal_weight_height,Colors.green),
            LineBarDataget(isboy? BoyWeightHeightLocalData.moderate_weight_height : GirlWeightHeightLocalData.moderate_weight_height,Colors.orange),
            LineBarDataget(isboy? BoyWeightHeightLocalData.severe_weight_height : GirlWeightHeightLocalData.severe_weight_height,Colors.red),
            LineChartBarData(
              spots: sample_data,
              isCurved: false,
              barWidth: 1,
              color: Colors.black,
            )
          ],

          titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                axisNameWidget: Text("Weight(kg)"),

              ),
              topTitles:  AxisTitles(
                axisNameWidget: Text("Height(cm)"),
              )
          ),
        ),

      ),
    );
  }


  Widget drawHeightMonthChart(sample_data,bool isboy){
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          //borderData: FlBorderData(show: false),
          lineBarsData: [
            // The red line
            LineBarDataget(isboy? BoyWeightHeightLocalData.over_height : GirlWeightHeightLocalData.over_height,Colors.pink),
            LineBarDataget(isboy? BoyWeightHeightLocalData.normal_height : GirlWeightHeightLocalData.normal_height,Colors.green),
            LineBarDataget(isboy? BoyWeightHeightLocalData.risk_height : GirlWeightHeightLocalData.risk_height,Colors.yellow),
            LineBarDataget(isboy? BoyWeightHeightLocalData.moderate_height : GirlWeightHeightLocalData.moderate_height,Colors.orange),
            LineBarDataget(isboy? BoyWeightHeightLocalData.severe_height : GirlWeightHeightLocalData.severe_height,Colors.red),
            LineChartBarData(
              spots: sample_data,
              isCurved: false,
              barWidth: 1,
              color: Colors.black,
            )
          ],

          titlesData: FlTitlesData(
            rightTitles: AxisTitles(
              axisNameWidget: Text("Height(cm)"),

            ),
            topTitles:  AxisTitles(
              axisNameWidget: Text("Month"),
            )
          ),
        ),

      ),
    );
  }

  Widget drawWeightMonthChart(sample_data,bool isboy){
    return AspectRatio(
      aspectRatio: 1.5,
      child: LineChart(
        LineChartData(
          //borderData: FlBorderData(show: false),
          lineBarsData: [
            // The red line
            LineBarDataget(isboy? BoyWeightHeightLocalData.over_weight : GirlWeightHeightLocalData.over_weight,Colors.pink),
            LineBarDataget(isboy? BoyWeightHeightLocalData.normal_weight : GirlWeightHeightLocalData.normal_weight,Colors.green),
            LineBarDataget(isboy? BoyWeightHeightLocalData.risk_weight : GirlWeightHeightLocalData.risk_weight,Colors.yellow),
            LineBarDataget(isboy? BoyWeightHeightLocalData.moderate_weight : GirlWeightHeightLocalData.moderate_weight,Colors.orange),
            LineBarDataget(isboy? BoyWeightHeightLocalData.severe_weight : GirlWeightHeightLocalData.severe_weight,Colors.red),
            LineChartBarData(
              spots: sample_data,
              isCurved: false,
              barWidth: 1,
              color: Colors.black,
            )
            //   LineChartBarData(
            //     spots: sampale_data,
            //     isCurved: false,
            //     barWidth: 3,
            //     color: Colors.blue,
            //   )
          ],

          titlesData: FlTitlesData(
              rightTitles: AxisTitles(
                axisNameWidget: Text("Weight(kg)"),

              ),
              topTitles:  AxisTitles(
                axisNameWidget: Text("Month"),
              ),
          ),
        ),

      ),
    );
  }

  LineChartBarData LineBarDataget(dummyData,Color color){
    return LineChartBarData(
      dotData: const FlDotData(show: false),
      spots: List.generate(dummyData.length, (index) {
        return FlSpot(index.toDouble(), dummyData[index]);
      }),
      isCurved: true,
      barWidth: 3,
      color: color,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            ColorTween(begin: color, end: color)
                .lerp(0.9)!
                .withOpacity(0.5),
            ColorTween(begin: color, end: color)
                .lerp(0.9)!
                .withOpacity(0.1),
          ],
        ),

      ),

    );
  }


  LineChartBarData LineBarDatagetForHeight(dummyData,Color color){
    return LineChartBarData(
      dotData: const FlDotData(show: false),
      spots: List.generate(dummyData.length, (index) {
        return FlSpot(GirlWeightHeightLocalData.height[index], dummyData[index]);
      }),
      isCurved: true,
      barWidth: 3,
      color: color,
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            ColorTween(begin: color, end: color)
                .lerp(0.9)!
                .withOpacity(0.5),
            ColorTween(begin: color, end: color)
                .lerp(0.9)!
                .withOpacity(0.1),
          ],
        ),

      ),

    );
  }
}
