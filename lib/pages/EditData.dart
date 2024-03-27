import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalapp1/class/WeightHeight.dart';
import 'package:medicalapp1/components/MyAppBarBack.dart';
import 'package:medicalapp1/detail/NutritionController.dart';
import 'package:medicalapp1/local/LocalImageSave.dart';
import 'package:medicalapp1/pages/ShowAllPatient.dart';

import '../detail/ChildDetailController.dart';
import '../detail/FamilyStatusController.dart';
import '../firebaseStore/SavePatient.dart';
import '../properties/Appcolor.dart';

class EditData extends StatefulWidget {
  final DocumentSnapshot? document;
  final List<WeightHeight> weightheightData;
  late String profileImage;

  EditData(
      this.document, this.profileImage,this.weightheightData, {
        Key? key,
      }) : super(key: key);

  @override
  State<EditData> createState() => _EditDataState();

}

class _EditDataState extends State<EditData> {
  int _currentStep = 0; // initial step
  static int _number_of_step=3;
  SavePatient savePatient=SavePatient();
  LocalImageSave localImageSave= LocalImageSave();

  // define child details
  //final childdetailKey = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> validateKeys = List.generate( _number_of_step, (index) =>GlobalKey<FormState>());

  ChildDetailController childDetailController = ChildDetailController();
  FamilyStatusController familyStatusController= FamilyStatusController();
  NutritionController nutritionController=NutritionController();


  @override
  void initState() {
    super.initState();
    savePatient.documentId= widget.document!.id;
    childDetailController.setdocumetDetails(widget.document);
    familyStatusController.setdocumetDetails(widget.document);
    nutritionController.setdocumetDetails(widget.document);
    nutritionController.weightheightData=widget.weightheightData;
  }

  Widget getProfileimage(imageUrl){
    try{
      localImageSave.initiate();
      //print(curruntdata["profileImage_name"]);
      //return FileImage(File("jdnc"));
      FileImage image= localImageSave.loadImage(imageUrl);
      //print(image.toString());
      return Image(
        image: image,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    }catch(e){
      print(e);
      return  Image.network(
        imageUrl,
        width: 200,
        height: 200,
        fit: BoxFit.cover,
      );
    }

  }





  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(source: source);
      if (image != null) {
        setState((){
          _selectedImage = image;
          print("image selected"+_selectedImage!.path);
        });

      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBarBack("Edit Patient Details"),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          childDetailController.content(validateKeys[0], context),
          familyStatusController.content(validateKeys[1], context),
          nutritionController.content(validateKeys[2], context, setState),
          Text("Select the Image",),
          AddingProfileImage(_selectedImage,_pickImage),

          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Change the border radius as needed
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red[900]!), // Set the background color to red light
                ),

                child: Text("Cancel",style: TextStyle(color: Colors.white),),
              ),
              ElevatedButton(
                onPressed: () async {

                  Map<String, TextEditingController> mergedControllers = {};
                  mergedControllers.addAll(childDetailController.childdetail_controller);
                  mergedControllers.addAll(familyStatusController.famlystatus_controller);
                  mergedControllers.addAll(nutritionController.nutrition_controller);

                  await savePatient.SaveFirebaseTextController(mergedControllers);
                  await savePatient.AddWeightHeight(nutritionController.weightheightData);
                  if (_selectedImage != null) {
                    savePatient.uploadProfileImage(_selectedImage!);
                    Navigator.pushNamed(context, "/home");
                  }else{
                    Navigator.pushNamed(context, "/showAllPatient");
                  }
                  //savePatient.SaveFirebaseTextController(familyStatusController.famlystatus_controller);



                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Change the border radius as needed
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue[900]!), // Set the background color to red light
                ),
                child: Text("Save",style: TextStyle(color: Colors.white),),
              ),

            ],
          ),
          SizedBox(height: 20.0),

        ],
      ),

    );
  }


  Widget AddingProfileImage(_selectedImage,Function _pickImage){
    return Column(
      children: [
        SizedBox.fromSize(size: Size.fromHeight(10)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Column(
                children: [
                  Icon(
                    Icons.photo_library, // Icon
                    color: Appcolor.middleGreen, // Color
                    size: 36, // Size
                  ),
                  Text("Gallery",style: TextStyle(color:Appcolor.middleGreen ),)
                ],
              ),
            ),
            IconButton(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Column(
                children: [
                  Icon(
                    Icons.camera_alt, // Icon
                    color: Appcolor.darkOrange, // Color
                    size: 36, // Size
                  ),
                  Text("Camera",style: TextStyle(color: Appcolor.darkOrange ),)
                ],
              ),
            ),
          ],
        ),
        Center(
          child: _selectedImage == null ?
            widget.profileImage != "" ?
            Image.network(
              widget.profileImage, // Replace with your image URL
              width: 200, // Set the desired width
              height: 200, // Set the desired height
              fit: BoxFit.cover, // Adjust the fit as per your requirement
            )
            :
            const Column(
              children: [
                Icon(
                  Icons.image,
                  color: Appcolor.lightBlue,
                  size: 100,
                ),

                Text("No image is selected",style:TextStyle(color:Appcolor.lightBlue),)
              ],
            )
              : Image.file(
            File(_selectedImage!.path),
            // You can customize the width, height, and fit of the image as needed.
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20),

      ],
    );
  }

}


