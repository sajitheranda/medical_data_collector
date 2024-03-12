import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/components/MyAppBarBack.dart';

class ChartWithDataEntry extends StatefulWidget {
  const ChartWithDataEntry({super.key});

  @override
  State<ChartWithDataEntry> createState() => _ChartWithDataEntryState();
}

class _ChartWithDataEntryState extends State<ChartWithDataEntry> {
  List<int> MonthData = [];
  List<double> WeightData = [];
  List<double> HeightData = [];

  TextEditingController month_controller = TextEditingController();
  TextEditingController weight_controller = TextEditingController();
  TextEditingController height_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarBack("Height weight Details"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller:month_controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'month',
              ),
            ),
            TextField(
              controller: weight_controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'weight(kg)',
              ),
            ),
            TextField(
              controller: height_controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'height(m)',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Parse input values and add them to the datasets
                  MonthData.add(int.parse(month_controller.text));
                  WeightData.add(double.parse(weight_controller.text));
                  HeightData.add(double.parse(height_controller.text));

                  // Clear text fields after adding data
                  month_controller.clear();
                  weight_controller.clear();
                  height_controller.clear();
                });
              },
              child: Text('Add Data'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to chart screen and pass xData and yData
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => ChartScreen(xData: xData, yData: yData),
                //   ),
                // );
              },
              child: Text('Draw Chart'),
            ),
            Text(MonthData.toString()),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label: Text('Month')),
              DataColumn(label: Text('Weight')),
              DataColumn(label: Text('Height')),
              DataColumn(label: Text('Actions')),
            ],
            rows: List.generate(MonthData.length, (index) => DataRow(cells: [
                DataCell(Text(MonthData[index].toString())),
                DataCell(Text(WeightData[index].toString())),
                DataCell(Text(HeightData[index].toString())),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Edit button action
                        // You can add your edit logic here
                        print('Edit button pressed for index $index');
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Delete button action
                        // You can add your delete logic here
                        print('Delete button pressed for index $index');
                      },
                    ),
                  ],
                )),
                ]),
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }
}
