import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../attribute/PatientData.dart';


class FamilyStatusController{
  late Map<String,TextEditingController> famlystatus_controller;

  List<String> FamilyStatusNames=[
    PatientData.personsInHome ,
    PatientData.guardian ,
    PatientData.maritalState ,
    PatientData.children ,
    PatientData.headOfHouse,
    PatientData.numMembersOverseas ,
    PatientData.numMembersEarning ,
    PatientData.income ,
    PatientData.expense ,
    PatientData.homeCondition ,
    PatientData.vehicleType ,
    PatientData.smartphoneUsing

  ];

  FamilyStatusController(){
    famlystatus_controller= {
      PatientData.personsInHome : TextEditingController(),
      PatientData.guardian :TextEditingController(),
      PatientData.maritalState : TextEditingController(),
      PatientData.children : TextEditingController(),
      PatientData.headOfHouse: TextEditingController(),
      PatientData.numMembersOverseas : TextEditingController(),
      PatientData.numMembersEarning : TextEditingController(),
      PatientData.income : TextEditingController(),
      PatientData.expense : TextEditingController(),
      PatientData.homeCondition : TextEditingController(text:''),
      PatientData.vehicleType : TextEditingController(text:''),
      PatientData.smartphoneUsing : TextEditingController(text:'0')
    };

  }

  void setdocumetDetails(DocumentSnapshot? document){

    for (var element in FamilyStatusNames) {
      setValue(document!,famlystatus_controller[element]!,element);
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

  Map<String,TextEditingController> getFamilyStatusController(){
    return famlystatus_controller;
  }

  TextEditingController? getFamilyStatusControllerByName(String name){
    return famlystatus_controller[name];
  }



  Widget content(Key,BuildContext context){
    DateTime? selectedBirthdayDate = DateTime.now() ;

    Future<String> _selectDate(BuildContext context,TextEditingController controller) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920),
        lastDate: DateTime.now(),
      );

      if (pickedDate != null) {
        controller?.text= "${pickedDate.toLocal()}".split(' ')[0];
        return pickedDate as String;
      }
      return "no date";
    }
    List<String>? AreaTypes= ["Urban","State"];

    int getInitialLabelIndex(String labelText) {
      // Replace this logic with your own method to find the index of the label
      return labelText == 'Urban' ? 0 : 1;
    }

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
              controller: famlystatus_controller[PatientData.personsInHome],
              decoration: InputDecoration(labelText: 'Number of persons in home'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the number of persons";
                }
                int? parsedValue = int.tryParse(value);

                if(parsedValue == null || parsedValue <= 0){
                  return "Please enter a valid positive number";
                }

                return null;
              },

            ),

            DropdownButtonFormField(
              value : famlystatus_controller[PatientData.guardian]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                famlystatus_controller[PatientData.guardian]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("Father","Father"),
                getDropDownItem("Mother","Mother"),
                getDropDownItem("Other","Other"),
                // Add more items as needed
              ],
              decoration: const InputDecoration(
                labelText: 'Guardian',
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the guardian';
                }
                return null;
              },
            ),

            DropdownButtonFormField(
              value : famlystatus_controller[PatientData.maritalState]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                famlystatus_controller[PatientData.maritalState]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("Single","Single"),
                getDropDownItem("Married","Married"),
                getDropDownItem("Divorced","Divorced"),
                // Add more items as needed
              ],
              decoration: const InputDecoration(
                labelText: 'Matital State',
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the marital state';
                }
                return null;
              },
            ),

            TextFormField(
              controller: famlystatus_controller[PatientData.children],
              decoration: InputDecoration(labelText: 'Number of children'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the number of children";
                }
                int? parsedValue = int.tryParse(value);

                if(parsedValue == null || parsedValue <= 0){
                  return "Please enter a valid positive number";
                }

                return null;
              },

            ),
            //head_of_house
            DropdownButtonFormField(
              value : famlystatus_controller[PatientData.headOfHouse]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                famlystatus_controller[PatientData.headOfHouse]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("Father","Father"),
                getDropDownItem("Mother","Mother"),
                getDropDownItem("Other","Other")
                // Add more items as needed
              ],
              decoration: const InputDecoration(
                labelText: 'Head of house',
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the head of house';
                }
                return null;
              },
            ),
            //num_members_overseas
            TextFormField(
              controller: famlystatus_controller[PatientData.numMembersOverseas],
              decoration: InputDecoration(labelText: 'Number of members overseas'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the number";
                }
                int? parsedValue = int.tryParse(value);

                if(parsedValue == null || parsedValue< 0){
                  return "Please enter a valid positive number or zero";
                }

                return null;
              },

            ),

            TextFormField(
              controller: famlystatus_controller[PatientData.numMembersEarning],
              decoration: InputDecoration(labelText: 'Number of members earning'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the number";
                }
                int? parsedValue = int.tryParse(value);

                if(parsedValue == null || parsedValue< 0){
                  return "Please enter a valid positive number or zero";
                }

                return null;
              },

            ),

            // TextFormField(
            //   controller: famlystatus_controller["num_members_earning"],
            //   decoration: InputDecoration(labelText: 'Number of members earning'),
            //   validator: (value){
            //     if(value == null || value.isEmpty){
            //       return "Please enter the number";
            //     }
            //     int? parsedValue = int.tryParse(value);
            //
            //     if(parsedValue == null || parsedValue< 0){
            //       return "Please enter a valid positive number or zero";
            //     }
            //
            //     return null;
            //   },
            //
            // ),

            TextFormField(
              controller: famlystatus_controller[PatientData.income],
              decoration: InputDecoration(labelText: 'Monthly Income'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the monthly income";
                }
                int? parsedValue = int.tryParse(value);

                if(parsedValue == null || parsedValue< 0){
                  return "Please enter a valid positive number or zero";
                }

                return null;
              },

            ),

            TextFormField(
              controller: famlystatus_controller[PatientData.expense],
              decoration: InputDecoration(labelText: 'Monthly Expense'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the monthly expense";
                }
                int? parsedValue = int.tryParse(value);

                if(parsedValue == null || parsedValue< 0){
                  return "Please enter a valid positive number or zero";
                }

                return null;
              },

            ),

            DropdownButtonFormField(
              value : famlystatus_controller[PatientData.homeCondition]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                famlystatus_controller[PatientData.homeCondition]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("No house","No house"),
                getDropDownItem("Onestore house with tiles","One store house with tiles"),
                getDropDownItem("One store house without tiles","One store house without tiles"),
                getDropDownItem("Two store house","Two store house"),
                getDropDownItem("Other","Other")
                // Add more items as needed
              ],
              decoration: const InputDecoration(
                labelText: 'Home condition',
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the home condition';
                }
                return null;
              },
            ),

            DropdownButtonFormField(
              value : famlystatus_controller[PatientData.vehicleType]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                famlystatus_controller[PatientData.vehicleType]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("No vechicle","No vechicle"),
                getDropDownItem("Motor cycle","Motor cycle"),
                getDropDownItem("Three wheeler","Three wheeler"),
                getDropDownItem("Car","Car"),
                getDropDownItem("Van","Van")
                // Add more items as needed
              ],
              decoration: const InputDecoration(
                labelText: 'Vechical type',
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the vechical type';
                }
                return null;
              },
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Smart phone using :",style: TextStyle(fontSize: 15.0),),
                ToggleSwitch(
                  minWidth: 60.0,
                  cornerRadius: 20.0,
                  activeBgColors: [[Colors.red[800]!],[Colors.green[800]!] ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: int.parse(famlystatus_controller[PatientData.smartphoneUsing]!.text),
                  totalSwitches: 2,
                  labels: ['No', 'Yes'],
                  radiusStyle: true,
                  onToggle: (index) {
                    famlystatus_controller[PatientData.smartphoneUsing]?.text=index.toString();
                  },
                ),
              ],
            ),


            SizedBox(height: 20),


          ],
        )
    );
  }



}
