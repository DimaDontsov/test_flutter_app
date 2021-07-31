import 'package:flutter/material.dart';


class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              ],
            ),
          ),
          ListTile(
            title: Text("Галерея", style: TextStyle(color: Colors.black,),),
            leading: Icon(Icons.folder, color: Colors.black,),
            onTap: (){
              Navigator.pushReplacementNamed(context, '/gallery');
            },
          ),
          ListTile(
              title: Text("Обо мне", style: TextStyle(color: Colors.black,),),
              leading: Icon(Icons.people, color: Colors.black,),
              onTap: (){
                Navigator.pushReplacementNamed(context, '/about');
              }
          ),
        ],
      ),
    );
  }
}