import 'package:flutter/material.dart';
import '/properties/Appcolor.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  String topic="Medical Data Collector";

  MyAppBar(this.topic);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {  },
        icon: Container(
          padding: EdgeInsets.all(2.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Appcolor.textWhite,
          ),
          child: const CircleAvatar(
            radius: 15, // Adjust the radius as needed
            backgroundImage: AssetImage('assets/icons/icon1.jpg'), // Replace with the path to your image
          ),
        ),

      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            topic,
            style: TextStyle(color: Appcolor.textWhite),
          ),

        ]
      ),
      backgroundColor: Appcolor.mainColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}