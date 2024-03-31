import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/class/WeightHeight.dart';
import 'package:medicalapp1/local/LocalImageSave.dart';
import 'package:open_file_plus/open_file_plus.dart';
import '../components/MyAppBarHome.dart';
import '../generateDocuments/ExcelGeneration.dart';
import '../properties/Appcolor.dart';
import 'ShowData.dart';

class ShowAllPatient extends StatefulWidget {
  const ShowAllPatient({super.key});

  @override
  State<ShowAllPatient> createState() => _ShowAllPatientState();
}

class _ShowAllPatientState extends State<ShowAllPatient> with SingleTickerProviderStateMixin {
  LocalImageSave localImageSave = LocalImageSave();
  late TabController _tabController;
  String currenttype="All";
  int currentindex=0;
  List<String> Catogorytabs= ["All","State","Urban"];
  List<int> _counter= [0,0,0];

  Future<List<DocumentSnapshot>> getAllPatientData(String type) async{

    var firestore = FirebaseFirestore.instance;
    await localImageSave.initiate();
    QuerySnapshot query;


    switch (type) {
      case "State":
         query = await firestore.collection("patient")
            .where("isDelete", isEqualTo: 0) // Filter by Delete = 0
            .where("areatype", isEqualTo: "State")// Filter by Delete = 0
            .orderBy("timestamp", descending: true)
            .get();

         _counter[1] = query.docs.length;



        break;
      case "Urban":
        query = await firestore.collection("patient")
            .where("isDelete", isEqualTo: 0) // Filter by Delete = 0
            .where("areatype", isEqualTo: "Urban")// Filter by Delete = 0
            .orderBy("timestamp", descending: true)
            .get();
        _counter[2] = query.docs.length;


        break;
      default:
        query = await firestore.collection("patient")
            .where("isDelete", isEqualTo: 0)
            .orderBy("timestamp", descending: true)
            .get();
        _counter[0] = query.docs.length;
        break;
    }
    print("**"+_counter.toString());



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

  void _showSnackBar(BuildContext context, String message, Color color) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        // Set background color to transparent
        elevation: 0,
        // Remove shadow
        content: Card( // Wrap content in a Card
          shape: RoundedRectangleBorder( // Apply rounded border
            borderRadius: BorderRadius.circular(8.0),
          ),
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _doProceess(int tabIndex) {
    _showSnackBar(context,"Selected tab ${Catogorytabs[tabIndex]} \n  count = ${_counter[tabIndex]}",Colors.blue);

    setState(() {
      currentindex=tabIndex;
    });
  }

  @override
  initState(){
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);


  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.home,
              color: Appcolor.textWhite,
            ),
            onPressed:(){
              Navigator.pushNamed(context, "/home");
            },
          ),
          title: Row(
              children: <Widget>[
                Text(
                  "All patients",
                  style: TextStyle(color: Appcolor.textWhite),
                ),
                SizedBox(
                  width: 20,
                ),


              ]
          ),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (value) async {
                if (value == 'pdf') {

                } else if (value == 'excel') {
                  List<DocumentSnapshot> DocumentList= await getAllPatientData(Catogorytabs[currentindex]);
                  String filePath=await ExcelGeneration().createExcelSheetAllchild(DocumentList);
                  print(filePath);
                  // Handle PDF generation
                  _showSnackBar(context,"Generating Excelsheet",Colors.green);

                  try {
                    //final file = XFile(filePath);
                    final result = await OpenFile.open(filePath);
                    print(result.message);
                  } catch (e) {
                    print('Error opening file: $e');
                  }
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'pdf',
                  child: Row(
                    children: [
                      Icon(
                        Icons.picture_as_pdf,
                        color: Colors.blue, // Change the color here
                      ),
                      SizedBox(width: 8), // Add spacing between icon and text
                      Text('Generate PDF'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'excel',
                  child: Row(
                    children: [
                      Icon(
                        Icons.insert_drive_file,
                        color: Colors.green, // Change the color here
                      ),
                      SizedBox(width: 8), // Add spacing between icon and text
                      Text('Generate Excel'),
                    ],
                  ),
                ),
              ],
              iconColor: Colors.white,
              color: Colors.blue[100],
            ), //IconButton
          ],
          backgroundColor: Appcolor.mainColor,
          bottom: TabBar(
            indicatorColor: Colors.white, // Customize indicator color
            labelColor: Colors.white, // Customize selected tab label color
            unselectedLabelColor: Colors.grey,
            controller: _tabController,
            onTap: _doProceess,
            tabs: [
              Tab(icon: Icon(Icons.holiday_village,),text:Catogorytabs[0]),
              Tab(icon: Icon(Icons.landscape_outlined),text:Catogorytabs[1]),
              Tab(icon: Icon(Icons.location_city),text:Catogorytabs[2])
            ],
          ),
        ),
        body: TabBarView(

          children: [
            builderPatients("All"),
            builderPatients("State"),
            builderPatients("Urban")
          ],
        ),

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

  FutureBuilder<List<DocumentSnapshot>> builderPatients(String type){
    FutureBuilder<List<DocumentSnapshot>> DocumentList= FutureBuilder<List<DocumentSnapshot>>(
      future: getAllPatientData(type),
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
    );


    return DocumentList;

  }


}


