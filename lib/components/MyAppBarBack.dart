import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../properties/Appcolor.dart';

class MyAppBarBack extends StatelessWidget implements PreferredSizeWidget{
  String topic="";
  MyAppBarBack(this.topic);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_rounded,
          color: Appcolor.textWhite,
        ),
        onPressed:(){
          Navigator.pop(context);
        },
      ),
      title: Row(
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
