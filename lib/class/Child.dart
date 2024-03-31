import 'package:cloud_firestore/cloud_firestore.dart';

import '../attribute/PatientData.dart';

class Child{

  DocumentSnapshot? document;

  //child details
  String name = "" ;
  String contactNumber = "";
  String dateOfBirth = "";
  String address = "";
  String ethincity = "";
  String relationship = "";
  String schoolgoing = "";
  String areatype = "";
  String gender = "";

  //family status
  String personsInHome = "";
  String guardian = "";
  String maritalState = "";
  String children = "";
  String headOfHouse = "";
  String numMembersOverseas = "";
  String numMembersEarning = "";
  String income = "";
  String expense = "";
  String homeCondition = "";
  String vehicleType = "";
  String smartphoneUsing = "";
  String isDelete= "";

  //nutrition status
  String birthWeight = "";
  String birthHeight = "";
  String currentWeight = "";
  String currentHeight = "";
  String activityStatus = "";
  String caloriePerDay = "";
  String weight = "";
  String height = "";
  String month = "";
  String weightHeightForMonth = "";

  String _getValue(String name) {
      try {
        if (document?[name] != "") {
          return document?[name];
        } else {
          return "";
        }
      } catch (e) {
        return "";
      }
    }

  String _getValueYesNo(String name) {
    try {
      if (document?[name] == "1") {
        return "yes";
      } else {
        return 'no';
      }
    } catch (e) {
      return 'no';
    }
  }

  Child(DocumentSnapshot? document){
    this.document = document;

    name = _getValue(PatientData.name);
    contactNumber = _getValue(PatientData.contactNumber);
    dateOfBirth = _getValue(PatientData.dateOfBirth);
    address = _getValue(PatientData.address);
    ethincity = _getValue(PatientData.ethincity);
    relationship = _getValue(PatientData.relationship);
    schoolgoing = _getValueYesNo(PatientData.schoolgoing);
    areatype = _getValue(PatientData.areatype);
    gender = _getValue(PatientData.gender);

    personsInHome = _getValue(PatientData.personsInHome);
    guardian = _getValue(PatientData.guardian);
    maritalState = _getValue(PatientData.maritalState);
    children = _getValue(PatientData.children);
    headOfHouse = _getValue(PatientData.headOfHouse);
    numMembersOverseas = _getValue(PatientData.numMembersOverseas);
    numMembersEarning =  _getValue(PatientData.numMembersEarning);
    income =  _getValue(PatientData.income);
    expense =  _getValue(PatientData.expense);
    homeCondition =  _getValue(PatientData.homeCondition);
    vehicleType =  _getValue(PatientData.vehicleType);
    smartphoneUsing = _getValueYesNo(PatientData.smartphoneUsing);

    birthWeight = _getValue(PatientData.birthWeight);
    birthHeight = _getValue(PatientData.birthHeight);
    currentWeight = _getValue(PatientData.currentWeight);
    currentHeight = _getValue(PatientData.currentHeight);
    caloriePerDay = _getValue(PatientData.caloriePerDay);
    activityStatus = _getValue(PatientData.activityStatus);

  }

  List<String> dataAll(){
    return [
    name,
    contactNumber,
    dateOfBirth,
    address,
    ethincity ,
    relationship,
    schoolgoing ,
    areatype ,
    gender ,

    personsInHome,
    guardian ,
    maritalState,
    children ,
    headOfHouse,
    numMembersOverseas ,
    numMembersEarning,
    income ,
    expense ,
    homeCondition ,
    vehicleType ,
    smartphoneUsing,

    birthWeight,
    birthHeight,
    currentWeight,
    currentHeight,
    caloriePerDay,
    activityStatus
    ];

  }



}