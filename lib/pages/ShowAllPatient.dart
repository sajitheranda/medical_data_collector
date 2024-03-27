import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/class/WeightHeight.dart';
import 'package:medicalapp1/local/LocalImageSave.dart';
import '../components/MyAppBarHome.dart';
import 'ShowData.dart';

class ShowAllPatient extends StatefulWidget {
  const ShowAllPatient({super.key});

  @override
  State<ShowAllPatient> createState() => _ShowAllPatientState();
}

class _ShowAllPatientState extends State<ShowAllPatient> {
  LocalImageSave localImageSave = LocalImageSave();

  Future<List<DocumentSnapshot>> getAllPatientData() async{

    var firestore = FirebaseFirestore.instance;
    await localImageSave.initiate();
    QuerySnapshot query = await firestore.collection("patient")
        .where("isDelete", isEqualTo: 0) // Filter by Delete = 0
        .orderBy("timestamp", descending: true)
        .get();
    return query.docs;

  }

  Future<List<WeightHeight>> getListWeightHeight(documentID) async{

    try{

      List<WeightHeight> weightheightData=[];
      final CollectionReference weightheightCollection = FirebaseFirestore.instance.collection("patient").doc(documentID).collection('weightheight');
      final QuerySnapshot weightheightSnapshot = await weightheightCollection.get();

      if (weightheightSnapshot.docs.isNotEmpty) {

        weightheightSnapshot.docs.forEach((weightheightDocument) {
          WeightHeight weightHeight = WeightHeight.fromJson(weightheightDocument);
          weightheightData.add(weightHeight);
        });
        return weightheightData;
      } else {
        print("no data");
        return [];
      }

    }catch(e){
      print("error");
      return [];

    }

    return [];

  }

  @override
  initState(){
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBarHome("All Patients"),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: getAllPatientData(),
        builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot)
        {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    CircularProgressIndicator(),
                    SizedBox(height:10.0),
                    Text("Waiting",style: TextStyle(color: Colors.blue[700]),)
                  ]
              ),
            );
          }else if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot? document = snapshot.data?[index];
                  //print("id = "+document!.id.toString());
                  return  Card( // Wrapping the ListTile with a Card to add background color and border
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0), // Adjust the value as needed for the roundness
                    ),
                    color: Colors.lightBlue[50], // Change the background color as needed
                    elevation: 4, // Adjust the elevation as needed
                    margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0), // Padding for ListTile
                    child: ListTile(
                      onTap: () async {
                        // String documentId = document?.id as String;
                        // print("Selected document ID: $documentId");
                        List<WeightHeight> weightheightData= await getListWeightHeight(document?.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowData(
                              document, weightheightData
                            ),
                          ),
                        );
                      },
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.0), // Padding for content inside ListTile
                      leading: snapshot.data?[index]["profileImage"] != null && snapshot.data?[index]["profileImage"] != ""
                          ? CircleAvatar(
                        backgroundImage: getProfileimage(snapshot.data?[index]),//
                        // Customize the CircleAvatar as needed
                      )
                          : CircleAvatar(
                        backgroundColor: Colors.blue[600], // Change the color of the CircleAvatar as needed
                        child: Icon(Icons.person, color: Colors.white), // Change the icon color as needed
                      ),
                      title: Text(safeExtractString(snapshot.data?[index],"name"), style: TextStyle(color: Colors.blue[900]),),
                      subtitle: Text(safeExtractString(snapshot.data?[index],"contact_number")),//safeExtractString(snapshot.data?[index],"contact_number") //snapshot.data?[index]["contact_number"] as String)
                    ),
                  );
                },
            );
          }else if(snapshot.hasError){
            print(snapshot.error);
            return Center(child: Text(snapshot.error.toString(),style: TextStyle(color: Colors.blue[800],fontSize: 16.0),));

          }
          else{
            return Center(child: Text("No data",style: TextStyle(color: Colors.blue[800],fontSize: 16.0),));
          }
          return Text("exit");

        },
      ),

    );
  }

  String safeExtractString(dynamic data, String key) {
    try {
      return data?[key] as String;
    } catch (e) {
      print("Error fetching $key: $e");
      return "";
    }
  }

  ImageProvider<Object>? getProfileimage(curruntdata){
    return NetworkImage(curruntdata["profileImage"] as String);
    // try{
    //   //print(curruntdata["profileImage_name"]);
    //   //return FileImage(File("jdnc"));
    //   FileImage? image= localImageSave.loadImage(curruntdata["profileImage_name"]);
    //   //print(image.toString());
    //   return image;
    // }catch(e){
    //   print(e);
    //   localImageSave.downloadAndSaveImage(curruntdata["profileImage"] as String, curruntdata["profileImage_name"]);
    //   return NetworkImage(curruntdata["profileImage"] as String);
    //
    // }

  }
}


