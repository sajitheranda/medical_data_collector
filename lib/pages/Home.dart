import 'package:flutter/material.dart';
import '../components/MYAppBar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  MyAppBar("Medical Data Collector"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Buttonshow(context,"Adding Patient",Icons.person,"/addData"),
            Buttonshow(context,"Showing Patients",Icons.people,"/showAllPatient"),
            // Buttonshow(context,"Collection Status",Icons.dashboard,"/collectionStatus"),
            // Buttonshow(context,"weight height",Icons.dashboard,"/generateGraph"),
          ],
        ),
      )
    );
  }
}

Widget Buttonshow(context,String title,icon,routeName) {
  return Container(
    width: MediaQuery.of(context).size.width*0.8,
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: ElevatedButton(
        onPressed: (){
          Navigator.pushNamed(context, routeName);
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          backgroundColor: Colors.lightBlue[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),  // Set your desired border radius here
          ),// Set your desired padding here
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(icon),
              Text(title)
           ],
         ),


    ),
  );
}
