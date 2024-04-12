import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/pages/WeightHeightDataEntry.dart';
import 'package:medicalapp1/properties/Appcolor.dart';

import '../attribute/PatientData.dart';
import '../class/WeightHeight.dart';

class NutritionController{
  late Map<String,TextEditingController> nutrition_controller;

  List<String> nutritionNames=[
    PatientData.birthWeight,
    PatientData.birthHeight,
    PatientData.currentWeight,
    PatientData.currentHeight,
    PatientData.caloriePerDay,
    PatientData.activityStatus,
    PatientData.heightForAge,
    PatientData.weightForAge,
    PatientData.weightForHeight

  ];

  NutritionController(){
    nutrition_controller = {
      PatientData.birthWeight : TextEditingController(),
      PatientData.birthHeight :TextEditingController(),
      PatientData.currentWeight : TextEditingController(),
      PatientData.currentHeight : TextEditingController(),
      PatientData.caloriePerDay : TextEditingController(),
      PatientData.activityStatus : TextEditingController(text:''),
      PatientData.heightForAge : TextEditingController(text:''),
      PatientData.weightForAge : TextEditingController(text:''),
      PatientData.weightForHeight : TextEditingController(text:'')
    };

  }
  List<WeightHeight> weightheightData =[];


  void setdocumetDetails(DocumentSnapshot? document){

    for (var element in nutritionNames) {
      setValue(document!,nutrition_controller[element]!,element);
    }

  }

  void setValue(DocumentSnapshot document,TextEditingController controller,String type){
    try {
      if(document[type] != ""){
        controller.text =  document[type];
      }
    }catch(e){
      print(e);
    }
  }

  Widget content(Key,BuildContext context,Function setState){

    // DateTime? selectedBirthdayDate = DateTime.now() ;
    //
    // Future<String> _selectDate(BuildContext context,TextEditingController controller) async {
    //   final DateTime? pickedDate = await showDatePicker(
    //     context: context,
    //     initialDate: DateTime.now(),
    //     firstDate: DateTime(1920),
    //     lastDate: DateTime.now(),
    //   );
    //
    //   if (pickedDate != null) {
    //     controller?.text= "${pickedDate.toLocal()}".split(' ')[0];
    //     return pickedDate as String;
    //   }
    //   return "no date";
    // }
    // List<String>? AreaTypes= ["Urban","State"];
    //
    // int getInitialLabelIndex(String labelText) {
    //   // Replace this logic with your own method to find the index of the label
    //   return labelText == 'Urban' ? 0 : 1;
    // }

    DropdownMenuItem getDropDownItem(value,txt){
      return DropdownMenuItem(
        value: value,
        child: Text(txt,style:TextStyle( fontWeight: FontWeight.normal,),),
      );

    }

    return Form(
        key: Key,
        child: Column(
          children: [
            TextFormField(
              controller: nutrition_controller[PatientData.birthWeight],
              decoration: InputDecoration(labelText: 'birth weight (kg)'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the birth weight";
                }
                double? parsedValue = double.tryParse(value);

                if(parsedValue == null || parsedValue <= 0){
                  return "Please enter a valid positive number";
                }

                return null;
              },

            ),

            TextFormField(
              controller: nutrition_controller[PatientData.birthHeight],
              decoration: InputDecoration(labelText: 'birth height (cm)'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the birth height";
                }
                double? parsedValue = double.tryParse(value);

                if(parsedValue == null || parsedValue <= 0){
                  return "Please enter a valid positive number";
                }

                return null;
              },

            ),

            TextFormField(
              controller: nutrition_controller[PatientData.currentWeight],
              decoration: InputDecoration(labelText: 'Current weight (kg)'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the current weight";
                }
                double? parsedValue = double.tryParse(value);

                if(parsedValue == null || parsedValue <= 0){
                  return "Please enter a valid positive number";
                }

                return null;
              },

            ),

            TextFormField(
              controller: nutrition_controller[PatientData.currentHeight],
              decoration: InputDecoration(labelText: 'Current height (cm)'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the current height";
                }
                double? parsedValue = double.tryParse(value);

                if(parsedValue == null || parsedValue <= 0){
                  return "Please enter a valid positive number";
                }

                return null;
              },

            ),

            TextFormField(
              controller: nutrition_controller[PatientData.caloriePerDay],
              decoration: InputDecoration(labelText: 'Calorie per day (kcal)'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the Calorie per day";
                }
                double? parsedValue = double.tryParse(value);

                if(parsedValue == null || parsedValue <= 0){
                  return "Please enter a valid positive number";
                }

                return null;
              },

            ),

            DropdownButtonFormField(
              value : nutrition_controller[PatientData.activityStatus]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                nutrition_controller[PatientData.activityStatus]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("Sedentary","Sedentary"),
                getDropDownItem("Lightly activity","Lightly activity"),
                getDropDownItem("Moderate activity","Moderate activity"),
                getDropDownItem("Very activity","Very activity"),
                // Add more items as needed
              ],
              decoration: const InputDecoration(
                labelText: 'Activity status',
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the Activity status';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            DropdownButtonFormField(
              value : nutrition_controller[PatientData.heightForAge]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                nutrition_controller[PatientData.heightForAge]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("SLH","SLH"),
                getDropDownItem("MLH","MLH"),
                getDropDownItem("RLH","RLH"),
                getDropDownItem("NH","NH"),
                // Add more items as needed
              ],
              decoration: InputDecoration(
                labelText: PatientData.heightForAgeWord,
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the height for age';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            DropdownButtonFormField(
              value : nutrition_controller[PatientData.weightForAge]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                nutrition_controller[PatientData.weightForAge]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("SLW","SLW"),
                getDropDownItem("MLW","MLW"),
                getDropDownItem("RLW","RLW"),
                getDropDownItem("NW","NW"),
                getDropDownItem("OW","OW"),
                // Add more items as needed
              ],
              decoration: InputDecoration(
                labelText: PatientData.weightForAgeWord,
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the weight for age';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            DropdownButtonFormField(
              value : nutrition_controller[PatientData.weightForHeight]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                nutrition_controller[PatientData.weightForHeight]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("SAM","SAM"),
                getDropDownItem("MAM","MAM"),
                getDropDownItem("NW","NW"),
                getDropDownItem("OW","OW"),
                // Add more items as needed
              ],
              decoration: InputDecoration(
                labelText: PatientData.weightForHeightWord,
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the Weight for Height';
                }
                return null;
              },
            ),
            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.mainColor, // Set the background color here
              ),
              onPressed: () async {
                final updatedWeightHeightData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeightHeightDataEntry(WeightHeightData: weightheightData),
                  ),
                );

                // Handle updated data (e.g., update UI).
                if (updatedWeightHeightData != null) {
                  //Assuming you have a setState method to update the UI.
                  setState((){
                    weightheightData = updatedWeightHeightData;
                  });

                    print("todo ="+weightheightData.length.toString());
                }


              },
              child: Text('Weight Height informations',style: TextStyle(color:Colors.white),),
            ),
            SizedBox(height: 20),
            WeightHeightDataEntry.showWeightHeightDataTable(weightheightData),

            SizedBox(height: 20),


          ],
        )
    );
  }


}