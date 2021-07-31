import 'package:flutter/material.dart';


class MyAppBar extends StatelessWidget implements PreferredSizeWidget {

  String titleText = "";

  MyAppBar({Key? key, required this.titleText}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(titleText, style: TextStyle(color: Colors.white,),),
      backgroundColor: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
    );
  }
}


