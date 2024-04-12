import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/attribute/PatientData.dart';
import 'package:medicalapp1/firebaseStore/SavePatient.dart';
import 'package:medicalapp1/pages/GeneratedGraph.dart';
import 'package:medicalapp1/pages/WeightHeightDataEntry.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import '../class/CaloryDetails.dart';
import '../class/Child.dart';
import '../class/WeightHeight.dart';
import '../components/MyAppBarBack.dart';
import '../generateDocuments/PdfGeneration.dart';
import '../local/LocalImageSave.dart';
import '../properties/Appcolor.dart';
import 'EditData.dart';

class ShowData extends StatefulWidget {
  final DocumentSnapshot? document;
  final List<WeightHeight> weightheightData;


  ShowData(
      this.document, this.weightheightData, {
        Key? key,
      }) : super(key: key);


  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {

  late String documentId;
  late String profileImage;
  LocalImageSave localImageSave = LocalImageSave();
  late Child child;


  SavePatient savePatient= SavePatient();

  Widget getProfileimage(imageUrl){
    return  Image.network(
      imageUrl,
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );

  }

  @override
  void initState() {
    super.initState();
    // Check if widget.document is not null, then access its id property
    documentId = widget.document?.id ?? '';
    profileImage = widget.document?["profileImage"]??"";

    child= Child(widget.document);


  }

  @override
  Widget build(BuildContext context) {
    print("length= "+widget.weightheightData.length.toString());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Appcolor.textWhite,
          ),
          onPressed:(){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
              onPressed: (){
                Printing.layoutPdf(
                  // [onLayout] will be called multiple times
                  // when the user changes the printer or printer settings
                  onLayout: (PdfPageFormat format) {
                    // Any valid Pdf document can be returned here as a list of int
                    return PdfGeneration().createPdfOneChildNew(format,widget.document,widget.weightheightData);
                  },
                );
              },
              icon: Icon(Icons.picture_as_pdf_rounded, color: Colors.white,))
        ],
        title: Row(
            children: <Widget>[
              Text(
                "Child Deatails",
                style: TextStyle(color: Appcolor.textWhite),
              ),

            ]
        ),
        backgroundColor: Appcolor.mainColor,
      ),
      body: ListView(
        children: [
          SizedBox(height: 20.0),
          profileImage != null && profileImage != ""
              ? CircleAvatar(
            radius: 100,
            child: ClipOval(
              child: getProfileimage(profileImage),
            ),
          )
              : CircleAvatar(
            backgroundColor: Colors.blue[600], // Change the color of the CircleAvatar as needed
            child: Icon(Icons.person, color: Colors.white,size: 100.0), // Change the icon color as needed
            radius: 100, // Change the radius to your desired size
          ),
          SizedBox(height: 20.0),
          // showItem("Name",name),
          // showItem("Contact number",contactNumber),
          // showItem("Date of birth",dateOfBirth),
          // showItem("Address",address),
          // showItem("ethincity",ethincity),
          // showItem("Relationship",relationship),
          // showItem("School going",schoolgoing),
          // showItem("Area type",areatype),
          // showItem("Gender",gender),
          //
          // showItem("Persons in home",personsInHome),
          // showItem("Guardian",guardian),
          // showItem("Marital State",maritalState),
          // showItem("Number of children",children),
          // showItem("Head of house",headOfHouse),
          // showItem("Number of members overseas",numMembersOverseas),
          // showItem("Number of members overseas",numMembersEarning),
          // showItem("Income",income),
          // showItem("Expense",expense),
          // showItem("Home condition",homeCondition),
          // showItem("Vechical type",vehicleType),
          // showItem("Smart phone using",smartphoneUsing),
          //
          // showItem("Birth weight",birthWeight),
          // showItem("Birth height",birthHeight),
          // showItem("Current weight",currentWeight),
          // showItem("Current height",currentHeight),
          // showItem("Calory per day",caloriePerDay),
          // showItem("activity status",activityStatus),

          for (int i = 0; i < PatientData.childWording.length; i++)
            showItem(PatientData.childWording[i],child.dataAll()[i]),

          CaloryDetails.GetNetCaloryWidget(
              child.dateOfBirth,
              child.caloriePerDay,
              child.gender,
              child.activityStatus
          ),

          SizedBox(height: 20.0),
          WeightHeightDataEntry.showWeightHeightDataTable(widget.weightheightData),
          SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GeneratedGraph(
                        widget.weightheightData,
                        child.gender
                    ),
                  ),
                );

              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Change the border radius as needed
                  ),
                ),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.all(20.0),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green[900]!), // Set the background color to red light
              ),
              child: Text("Generate Child Graphs",style: TextStyle(color: Colors.white),),
            ),
          ),

          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: (){
                  openDialog(savePatient,context,child.name,documentId);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Change the border radius as needed
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red[900]!), // Set the background color to red light
                ),

                child: Text("Delete",style: TextStyle(color: Colors.white),),
              ),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditData(
                            widget.document,
                            profileImage,
                            widget.weightheightData
                        ),
                      ),
                    );

                  },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Change the border radius as needed
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.orange[900]!), // Set the background color to red light
                ),
                  child: Text("Edit",style: TextStyle(color: Colors.white),),
              ),

            ],
          ),
          SizedBox(height: 20.0),




        ],
      ),

    );
  }
}

Widget showItem(String name, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue), // Add border color as needed
        borderRadius: BorderRadius.circular(5.0), // Adjust border radius as needed
        color: Colors.blue[50], // Add background color as needed
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.all(8.0), // Adjust inner padding as needed
              child: Text("$name = ", style: TextStyle(fontSize: 16, color: Colors.blue[800])),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0), // Adjust inner padding as needed
              child: Text(value, style: TextStyle(fontSize: 16)),
            ),
          )
        ],
      ),
    ),
  );
}

void openDialog(SavePatient savePatient,BuildContext context,String name, String id) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Delete Data",style: TextStyle(color: Colors.blue[900]),),
        content: Text("Are you want to delete data of $name ?"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Close the dialog box
              Navigator.of(context).pop();
            },
            child: Text("Close"),
          ),

          TextButton(
            onPressed: () {
              savePatient.documentId=id;
              savePatient.DeleteRowData();
              Navigator.pushNamed(context, "/home");
              // Close the dialog box
            },
            child: Text("Delete",style: TextStyle(color: Colors.red[900])),
          ),
        ],
      );
    },
  );



}
