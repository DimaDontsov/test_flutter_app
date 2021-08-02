import 'package:flutter/material.dart';


class MenuItem {

  late String route;
  late String name;
  late IconData icon;

  MenuItem(String route, name, icon) {
    this.route = route;
    this.name = name;
    this.icon = icon;
  }

}

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<MenuItem> menuItems = [];
    menuItems.add(MenuItem('/gallery','Галерея', Icons.folder));
    menuItems.add(MenuItem('/about','Обо мне', Icons.people));

    String? currentRoute = ModalRoute.of(context)!.settings.name;

    List<Widget> listTiles = [];
    for (int i = 0; i < menuItems.length; i++) {
      var color = Colors.black;
      var tileColor = Colors.white;
      if (menuItems[i].route == currentRoute) {
        color = Colors.blue;
        tileColor = Color.fromRGBO(148, 204, 255, .5);
      }
      listTiles.add(
        ListTile(
          title: Text(menuItems[i].name, style: TextStyle(color: color,),),
          leading: Icon(menuItems[i].icon, color: color,),
          tileColor: tileColor,
          onTap: (){
            if (menuItems[i].route != currentRoute) {
              Navigator.pushReplacementNamed(context, menuItems[i].route);
            }
          },
        ),
      );
    }

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
          ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: listTiles,
          ),
        ],
      ),
    );
  }
}
