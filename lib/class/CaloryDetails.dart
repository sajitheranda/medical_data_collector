import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicalapp1/attribute/LocalValues.dart';

class CaloryDetails{
  late String birthdate;
  late double calory;
  late String gender;
  late String activity;
  late int age;

  CaloryDetails(this.birthdate,this.calory,this.gender,this.activity){
    age=calculateAge(this.birthdate);
  }

  getCaloryNet(){
    double netCalory=0;
    double activity_level = LocalValues().getActivityStatus(activity);
    if(age==-1){
      return 0.0;
    }else{
      if(gender=="Male"){
        netCalory= (60.9+ (22.7*age))*activity_level;
      }else{
        netCalory= (55.6+(22.7*age))*activity_level;
      }
      return netCalory;
    }
  }


  int calculateAge(String? birth) {
    try {
      // Parse the input string into a DateTime object
      DateTime birthDate= DateFormat('yyyy-MM-dd').parseStrict(birth!);
      if (birthDate == null) return -1;

      final now = DateTime.now();
      int age = now.year - birthDate.year;
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      // If parsing fails, return null
      return -1;
    }
  }

  static Widget GetNetCaloryWidget(String birthdate,String calory,String gender,String activity){
    double calorydouble=double.tryParse(calory) ?? 0.0;
    // print("birthdate = "+birthdate);
    if(calorydouble == 0 || birthdate == null || birthdate.isEmpty){
      return Container(
          padding: EdgeInsets.all(8.0),
          margin:EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Adjust the radius here
            color: Colors.red.shade900,
            border: Border.all(
              color: Colors.red.shade900,// Set the border color here
              width: 3, // Set the border width here
            ),
          ),
          child: Text("Net Calory Remaining : No data",style: TextStyle(fontSize: 16,color: Colors.white),)
      );
    }else{
      CaloryDetails caloryDetails = CaloryDetails(birthdate, calorydouble, gender, activity);
      double net=caloryDetails.getCaloryNet();
      print("net ="+net.toString());
      return Container(
          padding: EdgeInsets.all(8.0),
          margin:EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), // Adjust the radius here
            color: Colors.green.shade900,
            border: Border.all(
              color: Colors.green.shade900,// Set the border color here
              width: 3, // Set the border width here
            ),
          ),
          child: Text("Net Callery remain ${net.toStringAsFixed(2)} kcal",style: TextStyle(fontSize: 16,color: Colors.white),)
      );

    }


  }





}