import 'package:flutter/material.dart';
import 'package:test_flutter_app/widgets/myAppBar.dart';
import 'package:test_flutter_app/widgets/myDrawer.dart';


class MyGridList extends StatelessWidget {
  const MyGridList({Key? key}) : super(key: key);

  List<Image> images(BuildContext context) {
    return [
      Image.asset('assets/menu_icon.png'),
      Image.asset('assets/menu_icon.png'),
      Image.asset('assets/menu_icon.png'),
      Image.asset('assets/menu_icon.png'),
      Image.asset('assets/menu_icon.png'),
      Image.asset('assets/menu_icon.png'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return  GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      padding: const EdgeInsets.all(8),
      childAspectRatio: 1,
      children: images(context).toList(),
    );
  }
}


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
      body: Scrollbar(
        child: MyGridList(),
      ),
    );
  }
}


