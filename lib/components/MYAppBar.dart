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
            backgroundImage: AssetImage('assets/icons/iconnew.jpg'), // Replace with the path to your image
          ),
        ),

      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            topic,
            style: TextStyle(color: Appcolor.textWhite),
          ),
          SizedBox(
            width: 17,
          )

        ]
      ),
      backgroundColor: Appcolor.mainColor,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}