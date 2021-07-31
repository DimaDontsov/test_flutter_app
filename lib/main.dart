import 'package:flutter/material.dart';
import 'package:test_flutter_app/pages/aboutPage.dart';
import 'package:test_flutter_app/pages/galleryPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/gallery',
      routes: {
        '/gallery': (context) => GalleryPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}

