import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: GalleryPage(),
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
      appBar: AppBar(
        title: Text('Галерея', style: TextStyle(color: Colors.white,),),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(

        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/menu_icon.png'),
                    radius: 20,
                  ),
                  Padding(padding: EdgeInsets.only(top: 20),),
                  Text('Дмитрий Донцов', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),),
                  Padding(padding: EdgeInsets.only(top: 10),),
                  Text('test@mail.ru', style: TextStyle(fontSize:15, color: Colors.grey,),),
                  Padding(padding: EdgeInsets.only(top: 20),),
                  // Text('Count: ${_count}', style: TextStyle(fontSize:20, color: Colors.black,),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
