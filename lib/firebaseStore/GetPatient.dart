import 'package:cloud_firestore/cloud_firestore.dart';

class GetPatient{
  late Map<String, int> genderCount;
  late Map<String, int> guardianList;
  late Map<String, int> AreatypeList;
  late Map<String, int> ActivityStatusList;
  late Map<String, int> VehicalTypeList;
  late int totalCountPatient;


  initiate() async{
    genderCount = {};
    AreatypeList = {};
    guardianList={};
    ActivityStatusList={};
    VehicalTypeList={};
    totalCountPatient = 0;

    var firestore = FirebaseFirestore.instance;
    QuerySnapshot query = await firestore.collection("patient")
        .where("isDelete", isEqualTo: 0) // Filter by Delete = 0
        .orderBy("timestamp", descending: true)
        .get();

    totalCountPatient= query.docs.length;

    //the gender
    query.docs.forEach((doc) {
      try {
        dynamic data = doc.data();
        if (data != null) {
          String? gender = data["gender"];
          if (gender != null) {
            genderCount[gender] = (genderCount[gender] ?? 0) + 1;
          }
          //print("count $gender "+genderCount[gender].toString());
        }
      } catch (e) {
        // Handle any potential exceptions, such as type errors or missing fields
        print("Error while adding gender: $e");
        genderCount["other"] = (genderCount["other"] ?? 0) + 1;
      }
    });

    // Area type
    query.docs.forEach((doc) {
      try {
        dynamic data = doc.data();
        if (data != null) {
          String? areatype = data["areatype"];
          if (areatype != null && areatype!="") {
            AreatypeList[areatype] = (AreatypeList[areatype] ?? 0) + 1;
          }else{
            AreatypeList["other"] = (AreatypeList["other"] ?? 0) + 1;
          }
          //print("count $gender "+genderCount[gender].toString());
        }
      } catch (e) {
        // Handle any potential exceptions, such as type errors or missing fields
        print("Error while adding area type: $e");
        AreatypeList["other"] = (AreatypeList["other"] ?? 0) + 1;
      }
    });

    //guardian
    query.docs.forEach((doc) {
      try {
        dynamic data = doc.data();
        if (data != null) {
          String? guardian= data["guardian"];
          if (guardian != null && guardian !="") {
            guardianList[guardian] = (guardianList[guardian] ?? 0) + 1;
          }else{
            guardianList["other"] = (guardianList["other"] ?? 0) + 1;
          }
          //print("count $gender "+genderCount[gender].toString());
        }
      } catch (e) {
        // Handle any potential exceptions, such as type errors or missing fields
        print("Error while adding guardian: $e");
        guardianList["other"] = (guardianList["other"] ?? 0) + 1;
      }
    });

    //activity status
    query.docs.forEach((doc) {
      try {
        dynamic data = doc.data();
        if (data != null) {
          String? activityStatus= data["activity_status"];
          if (activityStatus != null && activityStatus !="") {
            ActivityStatusList[activityStatus] = (ActivityStatusList[activityStatus] ?? 0) + 1;
          }else{
            ActivityStatusList["other"] = (ActivityStatusList["other"] ?? 0) + 1;
          }
          //print("count $gender "+genderCount[gender].toString());
        }
      } catch (e) {
        // Handle any potential exceptions, such as type errors or missing fields
        print("Error while adding guardian: $e");
        ActivityStatusList["other"] = (ActivityStatusList["other"] ?? 0) + 1;
      }
    });

    //vehical type
    query.docs.forEach((doc) {
      try {
        dynamic data = doc.data();
        if (data != null) {
          String? vehicalType= data["vehicle_type"];
          if (vehicalType != null && vehicalType !="") {
            VehicalTypeList[vehicalType] = (VehicalTypeList[vehicalType] ?? 0) + 1;
          }else{
            VehicalTypeList["other"] = (VehicalTypeList["other"] ?? 0) + 1;
          }
          //print("count $gender "+genderCount[gender].toString());
        }
      } catch (e) {
        // Handle any potential exceptions, such as type errors or missing fields
        print("Error while adding guardian: $e");
        VehicalTypeList["other"] = (VehicalTypeList["other"] ?? 0) + 1;
      }
    });



  }




}