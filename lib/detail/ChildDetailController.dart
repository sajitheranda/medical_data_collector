import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../attribute/PatientData.dart';



class ChildDetailController {
  late Map<String,TextEditingController> childdetail_controller;

  ChildDetailController(){
    childdetail_controller = {
      PatientData.name : TextEditingController(),
      PatientData.contactNumber:TextEditingController(),
      PatientData.dateOfBirth: TextEditingController(),
      PatientData.address : TextEditingController(),
      PatientData.ethincity: TextEditingController(),
      PatientData.relationship : TextEditingController(),
      PatientData.schoolgoing : TextEditingController(text:'0'),
      PatientData.areatype : TextEditingController(text:'Urban'),
      PatientData.gender : TextEditingController(text:'Male'),
    };
  }

  void setdocumetDetails(DocumentSnapshot? document){
    setValue(document!,childdetail_controller[PatientData.name]!,PatientData.name);
    setValue(document!,childdetail_controller[PatientData.contactNumber]!,PatientData.contactNumber);
    setValue(document!,childdetail_controller[PatientData.dateOfBirth]!,PatientData.dateOfBirth);
    setValue(document!,childdetail_controller[PatientData.address]!,PatientData.address);
    setValue(document!,childdetail_controller[PatientData.ethincity]!,PatientData.ethincity);
    setValue(document!,childdetail_controller[PatientData.relationship]!,PatientData.relationship);
    setValue(document!,childdetail_controller[PatientData.schoolgoing]!,PatientData.schoolgoing);
    setValue(document!,childdetail_controller[PatientData.areatype]!,PatientData.areatype);
    setValue(document!,childdetail_controller[PatientData.gender]!,PatientData.gender);

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



  Widget content(Key,BuildContext context){
    //DateTime? selectedBirthdayDate = DateTime.now() ;



    Future<String> _selectDate(BuildContext context,TextEditingController controller) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (pickedDate != null) {
        controller?.text= "${pickedDate.toLocal()}".split(' ')[0];
        return pickedDate as String;
      }
      return "no date";
    }
    List<String>? AreaTypes= ["Urban","State"];
    List<String>? GenderTypes= ["Male","Female"];

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
              controller: childdetail_controller[PatientData.name],
              decoration: InputDecoration(labelText: 'Name of child'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the name";
                }
                return null;
              },

            ),
            TextFormField(
              controller:  childdetail_controller[PatientData.contactNumber],
              decoration: InputDecoration(labelText: 'Contact Number'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter your contact number";
                }
                RegExp regex = RegExp(r'^[0-9]{10}$');
                if (!regex.hasMatch(value)) {
                  return 'Invalid contact number. Please enter 10 numbers.';
                }
                return null;
              },

            ),
            TextFormField(
              controller: childdetail_controller[PatientData.address],
              decoration: InputDecoration(labelText: 'address'),
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please enter the address";
                }
                return null;
              },

            ),

            DropdownButtonFormField(
              value : childdetail_controller[PatientData.ethincity]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                childdetail_controller[PatientData.ethincity]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("Sinhala","Sinhala"),
                getDropDownItem("Tamil","Tamil"),
                getDropDownItem("Muslim","Muslim"),
                // Add more items as needed
              ],
              decoration: const InputDecoration(
                labelText: 'Ethnicity',
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the ethnicity';
                }
                return null;
              },
            ),

            DropdownButtonFormField(
              value : childdetail_controller[PatientData.relationship]?.text??'',
              onChanged: (newValue) {
                // Update the state when the value changes
                childdetail_controller[PatientData.relationship]?.text = newValue.toString();
              },
              items: [
                getDropDownItem("","select"),
                getDropDownItem("Father","Father"),
                getDropDownItem("Mother","Mother"),
                getDropDownItem("Brother","Brother"),
                getDropDownItem("Sister","Sister"),
                getDropDownItem("Other","Other")
                // Add more items as needed
              ],
              decoration: const InputDecoration(
                labelText: 'Relationship',
                // You can add more styling here if needed
              ),
              validator: (value) {
                if (value == null || value.isEmpty ||value == '') {
                  return 'Please select the relationship';
                }
                return null;
              },
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: childdetail_controller[PatientData.dateOfBirth],
                    decoration: InputDecoration(labelText: "Date of birth"),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter the date of birth";
                      }

                      try {
                        DateTime.parse(value);
                        return null; // Valid date
                      } catch (e) {
                        return "Invalid date format"; // Invalid date
                      }
                      return null;

                    },
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _selectDate(context,childdetail_controller[PatientData.dateOfBirth]!);
                    },
                    icon: const Icon(
                        Icons.calendar_month
                    )
                ),
              ],
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("School going :",style: TextStyle(fontSize: 15.0),),
                ToggleSwitch(
                  minWidth: 60.0,
                  cornerRadius: 20.0,
                  activeBgColors: [[Colors.red[800]!],[Colors.green[800]!] ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: int.parse(childdetail_controller[PatientData.schoolgoing]!.text),
                  totalSwitches: 2,
                  labels: ['No', 'Yes'],
                  radiusStyle: true,
                  onToggle: (index) {
                    childdetail_controller[PatientData.schoolgoing]?.text=index.toString();
                  },
                ),
              ],
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Area :",style: TextStyle(fontSize: 15.0),),
                ToggleSwitch(
                  minWidth: 60.0,
                  cornerRadius: 20.0,
                  activeBgColors: [[Colors.orange[800]!],[Colors.orange[800]!] ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: AreaTypes.indexOf(childdetail_controller["areatype"]!.text),
                  totalSwitches: 2,
                  labels: AreaTypes,
                  radiusStyle: true,
                  onToggle: (index) {
                    if (index != null){
                      childdetail_controller[PatientData.areatype]?.text=AreaTypes[index];
                    }

                  },
                ),
              ],
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Gender :",style: TextStyle(fontSize: 15.0),),
                ToggleSwitch(
                  minWidth: 60.0,
                  cornerRadius: 20.0,
                  activeBgColors: [[Colors.purple[800]!],[Colors.purple[800]!] ],
                  activeFgColor: Colors.white,
                  inactiveBgColor: Colors.grey,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: GenderTypes.indexOf(childdetail_controller[PatientData.gender]!.text),
                  totalSwitches: 2,
                  labels: GenderTypes,
                  radiusStyle: true,
                  onToggle: (index) {
                    if (index != null){
                      childdetail_controller[PatientData.gender]?.text=GenderTypes[index];
                    }

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