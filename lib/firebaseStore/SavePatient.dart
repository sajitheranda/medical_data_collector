
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:medicalapp1/local/LocalImageSave.dart';
import 'package:uuid/uuid.dart';

import '../class/WeightHeight.dart';

class SavePatient{
  final userRef = FirebaseFirestore.instance.collection('patient');
  String documentId ='';

  Future<void> SaveFirebaseTextController(Map<String,TextEditingController> controller) async {

    Map<String, dynamic> dataToFirebase = {};

    controller.forEach((key, value) {
      dataToFirebase[key] = value.text;
    });

    dataToFirebase['timestamp'] = FieldValue.serverTimestamp();


    // try {
    //   // Add data with auto-generated document ID
    //   DocumentReference docRef = await userRef.add(
    //       dataToFirebase
    //   );
    //   documentId = docRef.id;
    //   print("Data saved successfully");
    // } catch (e) {
    //   print("Error saving data: $e");
    // }


    if(documentId.isEmpty){
      try {
        dataToFirebase['profileImage'] = "";
        dataToFirebase['isDelete'] = 0;
        // Add data with auto-generated document ID
        DocumentReference docRef = await userRef.add(
            dataToFirebase
        );
        documentId = docRef.id;
        print("Data saved successfully");
      } catch (e) {
        print("Error saving data: $e");
      }

    }else{
      try {
        // Add data with auto-generated document ID
        await userRef.doc(documentId).update(dataToFirebase);
        print("Data updated successfully");
      } catch (e) {
        print("Error updating data: $e");
      }


    }


  }

  // Future<void> uploadPatientImage(XFile imageFile) async {
  //   Map<String, dynamic> dataToFirebase = {};
  //   dataToFirebase['timestamp'] = FieldValue.serverTimestamp();
  //
  //   try {
  //     String fileName = Uuid().v4();
  //     File file = File(imageFile.path); // Convert XFile to File
  //     firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
  //         .ref('images/$fileName');
  //     await ref.putFile(file); // Use the File object here
  //     String profileImageURL = await ref.getDownloadURL();
  //     print(profileImageURL);
  //
  //
  //
  //     // Now you have the download URL, you can store it in Firestore along with other data.
  //     dataToFirebase['profileImage'] = profileImageURL;
  //
  //
  //     if (documentId.isEmpty) {
  //       DocumentReference docRef = await userRef.add(dataToFirebase);
  //       documentId = docRef.id;
  //       print("Data saved successfully");
  //     } else {
  //       await userRef.doc(documentId).update(dataToFirebase);
  //       print("Data updated successfully");
  //     }
  //   } catch (e) {
  //     print('Error uploading image: $e');
  //   }
  // }

  Future<void> uploadProfileImage(XFile imageFile) async {
    Map<String, dynamic> dataToFirebase = {};
    dataToFirebase['timestamp'] = FieldValue.serverTimestamp();
    dataToFirebase['profileImage'] = "";
    try {
      File file = File(imageFile.path);
      final storageRef = FirebaseStorage.instance.ref().child("profile_pictures/");
      final imageName = Uuid().v4() + _getFileExtension(file);

      LocalImageSave localImageSave = LocalImageSave();
      await localImageSave.initiate();
      localImageSave.saveImageLocally(file,imageName.toString());
      print("************");

      final uploadTask = storageRef.child(imageName).putFile(file);
      final snapshot = await uploadTask;
      if (snapshot.state == TaskState.success) {
        final downloadUrl = await snapshot.ref.getDownloadURL();
        String imageUrl = downloadUrl.toString();
        dataToFirebase['profileImage'] = imageUrl;
        dataToFirebase['profileImage_name'] =  imageName.toString();
      } else {
        // Handle the case where the upload was not successful
        print("Error uploading image ");
      }
      if (documentId.isEmpty) {
        dataToFirebase['isDelete'] = 0;
        DocumentReference docRef = await userRef.add(dataToFirebase);
        documentId = docRef.id;
        print("Data saved successfully");
      } else {
        await userRef.doc(documentId).update(dataToFirebase);
        print("Data updated successfully");
      }
    } catch (e) {
      // Handle any exceptions
      print("Error uploading image: $e");
    }
  }

  String _getFileExtension(File file) {
    final fileName = file.path;
    final extension = fileName.split('.').last;
    return ".$extension";
  }


  Future<void> DeleteRowData() async {

    Map<String, dynamic> dataToFirebase = {};


    dataToFirebase['timestamp'] = FieldValue.serverTimestamp();
    dataToFirebase['isDelete'] = 1;


    if(documentId.isEmpty){
      print("error in deleteing data");
    }else{
      try {
        // Add data with auto-generated document ID
        await userRef.doc(documentId).update(dataToFirebase);
        print("Data deleted successfully");
      } catch (e) {
        print("Error deleting data: $e");
      }

    }


  }

  Future<void> AddWeightHeight(List<WeightHeight> weightheightData) async {
    Map<String, dynamic> dataToFirebase = {};
    dataToFirebase['timestamp'] = FieldValue.serverTimestamp();
    dataToFirebase['profileImage'] = "";
    try {

      final DocumentReference documentReference = userRef.doc(documentId);
      final CollectionReference weightheightCollection = documentReference.collection('weightheight');

      // Check if the subcollection exists
      final subcollectionSnapshot = await weightheightCollection.get();
      if (subcollectionSnapshot.docs.isNotEmpty) {
        // Delete existing documents in the collection
        await weightheightCollection.get().then((querySnapshot) {
          for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
            documentSnapshot.reference.delete();
          }
          print("deleting weight height data successfully");
        });
      }

      for (WeightHeight patient in weightheightData) {
        await weightheightCollection.add(patient.toJson());
      }

      await userRef.doc(documentId).update(dataToFirebase);
      print("Data added successfully");

    } catch (e) {
      // Handle any exceptions
      print("Error uploading image: $e");
    }
  }




}