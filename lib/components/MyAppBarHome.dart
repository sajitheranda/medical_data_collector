import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../properties/Appcolor.dart';

class MyAppBarHome extends StatelessWidget implements PreferredSizeWidget  {
  String topic="";
  MyAppBarHome(this.topic);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(
            Icons.home,
            color: Appcolor.textWhite,
        ),
        onPressed:(){
          Navigator.pushNamed(context, "/home");
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
