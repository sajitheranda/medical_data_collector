

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

class LocalImageSave{
  late Directory appDirectory;

  initiate() async {
   appDirectory = await getApplicationDocumentsDirectory() ;

  }

  // Future<String> saveImageLocally(File imageFile, String filename, {int quality = 90}) async {
  //   final Directory appDirectory = await getApplicationDocumentsDirectory();
  //   final String imagePath = '${appDirectory.path}/$filename';
  //
  //   // Compress the image if needed
  //   final File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
  //     imageFile.absolute.path,
  //     imagePath,
  //     quality: quality,
  //   );
  //
  //   // Move the compressed image to the target directory
  //   imageFile.rename(compressedImageFile.path);
  //
  //   return imagePath;
  // }


  Future<String> saveImageLocally(File? file, String filename, {int quality = 90}) async {

    // Convert XFile to File
    //final File file = File(imageFile!.path);

    // Get the app directory
    Directory appDirectory = await getApplicationDocumentsDirectory();

    // Construct the image path
    final String imagePath = '${appDirectory.path}/$filename';

    // Compress the image if needed
    // final File compressedImageFile = await FlutterImageCompress.compressAndGetFile(
    //   imageFile.path, // Use the path directly from the XFile
    //   imagePath,
    //   quality: quality,
    // );

    // Move the compressed image to the target directory
    await file?.copy(imagePath);
    print("saving correctly $imagePath");

    return imagePath;
  }

  FileImage loadImage(String filename){

    final String imagePath = '${appDirectory.path}/$filename';
    //print(imagePath);

    File imageFile = File(imagePath);
    // if (!imageFile.existsSync()) {
    //   // If image file doesn't exist, return null
    //   return null;
    // }

    return FileImage(imageFile);
  }

  Future<void> downloadAndSaveImage(String imageUrl, String imageName) async {
    // try {
    //   // Download the image from the network
    //   HttpClient httpClient = HttpClient();
    //   HttpClientRequest request = await httpClient.getUrl(Uri.parse(imageUrl));
    //   HttpClientResponse response = await request.close();
    //   List<int> bytes = await response.pipe<List<int>>(ByteStream());
    //
    //   // Save the image locally
    //   File file = File('${appDirectory.path}/$imageName');
    //   await file.writeAsBytes(bytes);
    //   print('Image saved locally: ${file.path}');
    // } catch (e) {
    //   print('Error downloading and saving image: $e');
    // }


    final http.Response response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final File localImage = File('${appDir.path}/$imageName');
      await localImage.writeAsBytes(response.bodyBytes);
      print('Image saved locally: ${localImage.path}');
    } else {
      print('Failed to load image: ${response.statusCode}');
    }
  }


}