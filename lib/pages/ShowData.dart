import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/attribute/PatientData.dart';
import 'package:medicalapp1/firebaseStore/SavePatient.dart';
import 'package:medicalapp1/pages/GeneratedGraph.dart';
import 'package:medicalapp1/pages/WeightHeightDataEntry.dart';
import '../class/CaloryDetails.dart';
import '../class/WeightHeight.dart';
import '../components/MyAppBarBack.dart';
import '../local/LocalImageSave.dart';
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
  late String name ;
  late String contactNumber ;
  late String dateOfBirth ;
  late String address ;
  late String ethincity;
  late String relationship;
  late String schoolgoing ;
  late String areatype ;
  late String gender;

  //family status
  late String personsInHome ;
  late String guardian ;
  late String maritalState ;
  late String children ;
  late String headOfHouse ;
  late String numMembersOverseas ;
  late String numMembersEarning ;
  late String income ;
  late String expense ;
  late String homeCondition ;
  late String vehicleType ;
  late String smartphoneUsing;

  late String birthWeight;
  late String birthHeight ;
  late String currentWeight ;
  late String currentHeight ;
  late String caloriePerDay;
  late String activityStatus;



  late String profileImage;

  LocalImageSave localImageSave = LocalImageSave();

  // static String name = "name" ;
  // static String contactNumber = "contact_number";
  // static String dateOfBirth = "dateOfBirth";
  // static String address = "address";
  // static String ethincity = "ethincity";
  // static String relationship = "relationship";
  // static String schoolgoing = "schoolgoing";
  // static String areatype = "areatype";
  //
  // //family status
  // static String personsInHome = "persons_in_home";
  // static String guardian = "guardian";
  // static String maritalState = "marital_state";
  // static String children = "children";
  // static String headOfHouse = "head_of_house";
  // static String numMembersOverseas = "num_members_overseas";
  // static String numMembersEarning = "num_members_earning";
  // static String income = "income";
  // static String expense = "expense";
  // static String homeCondition = "home_condition";
  // static String vehicleType = "vehicle_type";
  // static String smartphoneUsing = "smartphone_using";
  String getValue(String name){
    try {
      if(widget.document?[name] != ""){
        return  widget.document?[name];
      }else{
        return 'no data';
      }
    }catch(e){
      return 'no data';
    }
  }

  String getValueYesNo(String name){
    try {
      if(widget.document?[name] == "1"){
        return  "yes";
      }else{
        return 'no';
      }
    }catch(e){
      return 'no';
    }
  }

  SavePatient savePatient= SavePatient();

  Widget getProfileimage(imageUrl){
    return  Image.network(
      imageUrl,
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );
    // try{
    //   localImageSave.initiate();
    //   //print(curruntdata["profileImage_name"]);
    //   //return FileImage(File("jdnc"));
    //   FileImage image= localImageSave.loadImage(imageUrl);
    //   //print(image.toString());
    //   return Image(
    //     image: image,
    //     width: 200,
    //     height: 200,
    //     fit: BoxFit.cover,
    //   );
    // }catch(e){
    //   print(e);
    //   return  Image.network(
    //     imageUrl,
    //     width: 200,
    //     height: 200,
    //     fit: BoxFit.cover,
    //   );
    // }

  }

  @override
  void initState() {
    super.initState();
    // Check if widget.document is not null, then access its id property
    documentId = widget.document?.id ?? '';
    profileImage = widget.document?["profileImage"]??"";
    name =getValue(PatientData.name);
    contactNumber = getValue(PatientData.contactNumber);
    dateOfBirth = getValue(PatientData.dateOfBirth);
    address = getValue(PatientData.address);
    ethincity = getValue(PatientData.ethincity);
    relationship = getValue(PatientData.relationship);
    schoolgoing = getValueYesNo(PatientData.schoolgoing);
    areatype = getValue(PatientData.areatype);
    gender = getValue(PatientData.gender);

    personsInHome = getValue(PatientData.personsInHome);
    guardian = getValue(PatientData.guardian);
    maritalState = getValue(PatientData.maritalState);
    children = getValue(PatientData.children);
    headOfHouse = getValue(PatientData.headOfHouse);
    numMembersOverseas = getValue(PatientData.numMembersOverseas);
    numMembersEarning =  getValue(PatientData.numMembersEarning);
    income =  getValue(PatientData.income);
    expense =  getValue(PatientData.expense);
    homeCondition =  getValue(PatientData.homeCondition);
    vehicleType =  getValue(PatientData.vehicleType);
    smartphoneUsing = getValueYesNo(PatientData.smartphoneUsing);

    birthWeight = getValue(PatientData.birthWeight);
    birthHeight = getValue(PatientData.birthHeight);
    currentWeight = getValue(PatientData.currentWeight);
    currentHeight = getValue(PatientData.currentHeight);
    caloriePerDay = getValue(PatientData.caloriePerDay);
    activityStatus = getValue(PatientData.activityStatus);

  }

  @override
  Widget build(BuildContext context) {
    print("length= "+widget.weightheightData.length.toString());
    return Scaffold(
      appBar: MyAppBarBack("Patient Details"),
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
          showItem("Name",name),
          showItem("Contact number",contactNumber),
          showItem("Date of birth",dateOfBirth),
          showItem("Address",address),
          showItem("ethincity",ethincity),
          showItem("Relationship",relationship),
          showItem("School going",schoolgoing),
          showItem("Area type",areatype),
          showItem("Gender",gender),

          showItem("Persons in home",personsInHome),
          showItem("Guardian",guardian),
          showItem("Marital State",maritalState),
          showItem("Number of children",children),
          showItem("Head of house",headOfHouse),
          showItem("Number of members overseas",numMembersOverseas),
          showItem("Number of members overseas",numMembersEarning),
          showItem("Income",income),
          showItem("Expense",expense),
          showItem("Home condition",homeCondition),
          showItem("Vechical type",vehicleType),
          showItem("Smart phone using",smartphoneUsing),

          showItem("Birth weight",birthWeight),
          showItem("Birth height",birthHeight),
          showItem("Current weight",currentWeight),
          showItem("Current height",currentHeight),
          showItem("Calory per day",caloriePerDay),
          showItem("activity status",activityStatus),

          CaloryDetails.GetNetCaloryWidget(
              dateOfBirth,
              caloriePerDay,
              gender,
              activityStatus
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
                        gender
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
                  openDialog(savePatient,context,name,documentId);
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
