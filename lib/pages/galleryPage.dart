import 'package:flutter/material.dart';
import 'package:test_flutter_app/widgets/myAppBar.dart';
import 'package:test_flutter_app/widgets/myDrawer.dart';


class GalleryPage extends StatefulWidget {
  GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titleText: 'Галерея',),
      drawer: MyDrawer(),
    );
  }
}