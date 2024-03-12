import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicalapp1/attribute/PatientData.dart';
import 'package:medicalapp1/class/CaloryDetails.dart';
import 'package:medicalapp1/detail/FamilyStatusController.dart';
import 'package:medicalapp1/detail/NutritionController.dart';
import 'package:medicalapp1/firebaseStore/SavePatient.dart';
import 'package:medicalapp1/properties/Appcolor.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../detail/ChildDetailController.dart';
import '/components/MyAppBarHome.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  int _currentStep = 0; // initial step
  static int _number_of_step=4;
  SavePatient savePatient=SavePatient();

  // define child details
  //final childdetailKey = GlobalKey<FormState>();
  final List<GlobalKey<FormState>> validateKeys = List.generate( _number_of_step, (index) =>GlobalKey<FormState>());

  ChildDetailController childDetailController = ChildDetailController();
  FamilyStatusController familyStatusController= FamilyStatusController();
  NutritionController nutritionController =NutritionController();

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
        appBar: MyAppBarHome("Add Patient Data"),
        body: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if(_currentStep == 2){
              if (validateKeys[_currentStep].currentState?.validate() ?? false) {
                setState(() {
                  _currentStep += 1;
                });
                //nutritionController
                savePatient.SaveFirebaseTextController(nutritionController.nutrition_controller);
                savePatient.AddWeightHeight(nutritionController.weightheightData);
              }

            }else if (_currentStep < _number_of_step) {
                setState(() {
                  _currentStep += 1;
                });

              // if (validateKeys[_currentStep].currentState?.validate() ?? false) {
              //   setState(() {
              //     _currentStep += 1;
              //   });
              // }

              if(_currentStep == 1){
                savePatient.SaveFirebaseTextController(childDetailController.childdetail_controller);
              }else if(_currentStep==2){
                savePatient.SaveFirebaseTextController(familyStatusController.famlystatus_controller);
              }else if(_currentStep ==3){
                //nutritionController
                savePatient.SaveFirebaseTextController(nutritionController.nutrition_controller);
                savePatient.AddWeightHeight(nutritionController.weightheightData);
              }else if(_currentStep ==4){
                if (_selectedImage != null){
                  savePatient.uploadProfileImage(_selectedImage!);
                }

              }

            }else {
              print("finished");
              Navigator.pop(context);
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },

          steps: [
            Step(
              title: Text('Step 1 - Child Details'),

              content: childDetailController.content(validateKeys[0],context),
              isActive: _currentStep > 0,
              state: currentState(_currentStep,0)
            ),

            Step(
                title: Text('Step 2 - Family Status'),
                content: familyStatusController.content(validateKeys[1], context),
                isActive: _currentStep > 1,
                state: currentState(_currentStep,1)
            ),

            Step(
                title: Text('Step 3 - Nutrition details'),
                content: nutritionController.content(validateKeys[2], context,setState),
                isActive: _currentStep > 2,
                state: currentState(_currentStep,2)
            ),

            Step(
              title: Text('Step 4 - Adding image'),
              content:AddingProfileImage(_selectedImage,_pickImage),
                isActive: _currentStep > 3,
                state: currentState(_currentStep,3)

            ),
            Step(
                title: Text('Step 5 - Finished'),
                content:Column(
                  children: [
                    if (_selectedImage != null && _selectedImage!="") // Checking if an image is selected
                      Image.file( // Displaying the selected image
                        File(_selectedImage!.path),
                        width: 200, // Adjust width as needed
                        height: 200, // Adjust height as needed
                        fit: BoxFit.cover, // Adjust image fit as needed
                      ),

                    CaloryDetails.GetNetCaloryWidget(
                      childDetailController.childdetail_controller[PatientData.dateOfBirth]!.text??"",
                      nutritionController.nutrition_controller[PatientData.caloriePerDay]!.text??"",
                      childDetailController.childdetail_controller[PatientData.gender]!.text??"",
                      nutritionController.nutrition_controller[PatientData.activityStatus]!.text??""
                    ),

                  ],
                ),


            )
          ],

          controlsBuilder:(context,details){
              return Row(
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.mainColor, // Change this color to the desired background color
                      ),
                      onPressed: details.onStepContinue,
                      child:Text(_currentStep == _number_of_step ? "Submit" : "Next", style: TextStyle(color: Appcolor.textWhite),),
                  ),
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                  OutlinedButton(
                      onPressed: details.onStepCancel,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Appcolor.cancelDarkRed), // Change this color to the desired border color
                      ),
                      child: Text("Back",style: TextStyle(color:Appcolor.cancelDarkRed ),)
                  )
                ],
              );
          }


        ));
  }
}

StepState currentState( currentStep,step){
  return currentStep == step
      ? StepState.editing
      : currentStep > step
      ? StepState.complete
      : StepState.indexed;
}

Widget AddingProfileImage(_selectedImage,Function _pickImage){
  return Column(
    children: [
      Text("Select the Image",style: TextStyle(fontWeight: FontWeight.w500),),
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
        child: _selectedImage == null
            ? const Column(
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



