import 'package:flutter/material.dart';
import 'package:medicalapp1/class/WeightHeight.dart';
import 'package:medicalapp1/properties/Appcolor.dart';

import '../components/MyAppBarBack.dart';

class WeightHeightDataEntry extends StatefulWidget {

  late List<WeightHeight> WeightHeightData;

  WeightHeightDataEntry({super.key,required this.WeightHeightData});

  @override
  State<WeightHeightDataEntry> createState() => _WeightHeightDataEntryState();


  static Widget showWeightHeightDataTable(List<WeightHeight> WeightHeightData) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                    return Colors.blue.shade900; //.withOpacity(0.3);
                  }),
              headingTextStyle: TextStyle(color: Colors.white),
              //decoration:
              //dataRowColor: Colors.orange,
              columns: [
                DataColumn(label: Text('Month')),
                DataColumn(label: Text('Weight')),
                DataColumn(label: Text('Height')),
              ],
              rows: List.generate(
                WeightHeightData.length,
                    (index) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                          if (index.isEven) {
                            return Colors.blue.withOpacity(0.2);
                          }
                          return Colors.blue.withOpacity(0.01);
                          ; // Use default value for other states and odd rows.
                        }),
                    cells: [
                      DataCell(Text(WeightHeightData[index].month.toString())),
                      DataCell(Text(WeightHeightData[index].weight.toString())),
                      DataCell(Text(WeightHeightData[index].height.toString())),
                    ]
                    ),

              ),
            ),

          ),
          WeightHeightData.length ==0 ? Container(padding: EdgeInsets.all(5),child: Text("No data",style: TextStyle(color: Colors.blue[900]),),):Text(""),
        ]));
  }
}

class _WeightHeightDataEntryState extends State<WeightHeightDataEntry> {
  List<WeightHeight> WeightHeightData = [];

  TextEditingController month_controller = TextEditingController();
  TextEditingController weight_controller = TextEditingController();
  TextEditingController height_controller = TextEditingController();

  //late int newtodo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WeightHeightData= List.from(widget.WeightHeightData);;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarBack("Height weight Details"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                  return Colors.blue.shade900; //.withOpacity(0.3);
                }),
                headingTextStyle: TextStyle(color: Colors.white),
                //decoration:
                //dataRowColor: Colors.orange,
                columns: [
                  DataColumn(label: Text('Month')),
                  DataColumn(label: Text('Weight')),
                  DataColumn(label: Text('Height')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List.generate(
                  WeightHeightData.length,
                  (index) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (index.isEven) {
                          return Colors.blue.withOpacity(0.2);
                        }
                        return Colors.blue.withOpacity(0.01);
                        ; // Use default value for other states and odd rows.
                      }),
                      cells: [
                        DataCell(
                            Text(WeightHeightData[index].month.toString())),
                        DataCell(
                            Text(WeightHeightData[index].weight.toString())),
                        DataCell(
                            Text(WeightHeightData[index].height.toString())),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.orange,
                              ),
                              onPressed: () {
                                _editData(context, index);
                                print('Edit button pressed for index $index');
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _deleteData(context, index);

                                print('Delete button pressed for index $index');
                              },
                            ),
                          ],
                        )),
                      ]),

                ),
              ),
            ),
            WeightHeightData.length ==0 ? Center(child: Container(padding: EdgeInsets.all(5),child: Text("No data",style: TextStyle(color: Colors.blue[900]),),)):Text(""),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red[900], // Set the background color here
                  ),
                  onPressed: () {
                    Navigator.pop(context,widget.WeightHeightData);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.green[900], // Set the background color here
                  ),
                  onPressed: () {
                    Navigator.pop(context,WeightHeightData);
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addData(context);
          // Add your onPressed functionality here
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor:
            Appcolor.mainColor, // Optional: Change the background color
      ),
    );
  }

  void _editData(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        month_controller.text = WeightHeightData[index].month.toString();
        weight_controller.text = WeightHeightData[index].weight.toString();
        height_controller.text = WeightHeightData[index].height.toString();
        final _formKey = GlobalKey<FormState>();
        return AlertDialog(
          title: Text(
            'Edit Data',
            style: TextStyle(color: Colors.blue[900]),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: month_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Month',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a month';
                    }
                    int? month = int.tryParse(value);
                    if (month == null || month < 0 || month > 40) {
                      return 'Integer between 12 and 36';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: weight_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter weight';
                    }
                    double? weight = double.tryParse(value);
                    if (weight == null || weight <= 0) {
                      return 'Please enter a valid positive number';
                    }
                    // You can add more validation here if needed
                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: height_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter height';
                    }
                    double? height = double.tryParse(value);
                    if (height == null || height <= 0) {
                      return 'Please enter a valid positive number';
                    }
                    // You can add more validation here if needed
                    return null; // Return null if the input is valid
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red[900], // Set the background color here
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  month_controller.clear();
                  weight_controller.clear();
                  height_controller.clear();
                });
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green[900], // Set the background color here
              ),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    // Parse input values and add them to the datasets

                    WeightHeightData[index].month =
                        int.parse(month_controller.text);
                    WeightHeightData[index].weight =
                        double.parse(weight_controller.text);
                    WeightHeightData[index].height =
                        double.parse(height_controller.text);

                    // Clear text fields after adding data
                    month_controller.clear();
                    weight_controller.clear();
                    height_controller.clear();

                    Navigator.of(context).pop();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _addData(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final _formKey = GlobalKey<FormState>();
        return AlertDialog(
          title: Text(
            'Add Data',
            style: TextStyle(color: Colors.blue[900]),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  controller: month_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Month',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a month';
                    }
                    int? month = int.tryParse(value);
                    if (month == null || month < 0 || month > 40) {
                      return 'Integer between 12 and 36';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: weight_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter weight';
                    }
                    double? weight = double.tryParse(value);
                    if (weight == null || weight <= 0) {
                      return 'Please enter a valid positive number';
                    }
                    // You can add more validation here if needed
                    return null; // Return null if the input is valid
                  },
                ),
                TextFormField(
                  controller: height_controller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Height (cm)',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter height';
                    }
                    double? height = double.tryParse(value);
                    if (height == null || height <= 0) {
                      return 'Please enter a valid positive number';
                    }
                    // You can add more validation here if needed
                    return null; // Return null if the input is valid
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red[900], // Set the background color here
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                month_controller.clear();
                weight_controller.clear();
                height_controller.clear();
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.green[900], // Set the background color here
              ),
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    // Parse input values and add them to the datasets

                    int month = int.parse(month_controller.text);
                    double weight = double.parse(weight_controller.text);
                    double height = double.parse(height_controller.text);

                    WeightHeight weightHeight =
                        WeightHeight(month, weight, height);

                    WeightHeightData.add(weightHeight);

                    // Clear text fields after adding data
                    month_controller.clear();
                    weight_controller.clear();
                    height_controller.clear();
                  });

                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteData(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Data',
            style: TextStyle(color: Colors.blue[900]),
          ),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "Month = " + WeightHeightData[index].month.toString(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child:
                  Text("Weight = " + WeightHeightData[index].weight.toString()),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child:
                  Text("Height = " + WeightHeightData[index].height.toString()),
            ),
          ]),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.blue[900], // Set the background color here
              ),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.red[900], // Set the background color here
              ),
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  // Parse input values and add them to the datasets
                  // MonthData.removeAt(index);
                  // WeightData.removeAt(index);
                  // HeightData.removeAt(index);
                  WeightHeightData.removeAt(index);
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}
