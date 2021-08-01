import 'package:flutter/material.dart';
import 'package:test_flutter_app/pages/aboutPage.dart';
import 'package:test_flutter_app/pages/galleryPage.dart';
import 'package:test_flutter_app/pages/photoDetailPage.dart';
import 'package:test_flutter_app/photo.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/gallery',
      routes: {
        '/gallery': (context) => GalleryPage(),
        '/about': (context) => AboutPage(),
      },
      onGenerateRoute: _getRoute,
    );
  }

  Route<dynamic>? _getRoute(RouteSettings settings) {
    if (settings.name == '/photo_detail') {
      final photoInfo = settings.arguments as Photo;

      return MaterialPageRoute(
        builder: (context) {
          return PhotoDetailPage(photoInfo: photoInfo,);
        },
      );
    }
    return null;
  }
}

