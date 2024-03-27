import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicalapp1/components/ChartWithDataEntry.dart';
import 'package:medicalapp1/pages/GeneratedGraph.dart';
import 'package:medicalapp1/pages/LoginPage.dart';
import 'package:medicalapp1/pages/ShowAllPatient.dart';
import 'package:medicalapp1/pages/CollectionStatus.dart';
import 'package:medicalapp1/pages/Website.dart';
import 'package:medicalapp1/pages/WeightHeightDataEntry.dart';
import 'firebase_options.dart';
import 'pages/AddData.dart';
import 'pages/Home.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => MyApp(), // Wrap your app
  //   ),
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Detail collecting',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue.shade900),
        useMaterial3: true,
      ),
      home: LoginPage(),
      initialRoute: "/login",
      routes: {
        "/login":(context) => LoginPage(),
        "/home": (context) => Home(),
        "/addData": (context) => AddData(),
        "/showAllPatient": (context) => ShowAllPatient(),
        "/collectionStatus": (context) => CollctionStatus(),
        "/weightHeightdDataEntry": (context) => WeightHeightDataEntry(WeightHeightData: []),
        "/generateGraph": (context) => GeneratedGraph([],"Male"),
        "/webview":(context) => Website(),
      },
    );
  }
}
