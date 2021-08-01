import 'package:flutter/material.dart';
import 'package:test_flutter_app/widgets/myAppBar.dart';
import 'package:test_flutter_app/widgets/myDrawer.dart';
import 'package:test_flutter_app/photo.dart';


class PhotoDetailPage extends StatelessWidget {

  Photo photoInfo;

  PhotoDetailPage({Key? key, required this.photoInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titleText: 'Галерея',),
      drawer: MyDrawer(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  photoInfo.url,
                  // указываем максимальную ширину и высоту
                  width: 200,
                  height: 200,
                  // указываем масштабирование изображения
                  fit: BoxFit.cover,
                  // при загрузки изображения
                  // будет показан текст Loading...
                  loadingBuilder: (context, widget, imageChunkEvent) {
                    if (imageChunkEvent == null) {
                      return widget;
                    }
                    return Center(child: Text("Loading..."));
                  },
                  // при возникновении ошибки
                  // вместо изображения будет текст Error!
                  errorBuilder: (context, obj, stacktrace) {
                    print("Error ${obj.toString()}");
                    return Center(child: Text("Error!"));
                  },
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Row(
                  children: [
                    Text('albumId: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),),
                    Text(photoInfo.albumId.toString(), style: TextStyle(fontSize: 20, color: Colors.grey,),),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Row(
                  children: [
                    Text('ID картинки: ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),),
                    Text(photoInfo.id.toString(), style: TextStyle(fontSize: 20, color: Colors.grey,),),
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Container(
                  child: Text.rich(
                    TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Заголовок: ",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),
                          ),
                          TextSpan(
                            text: photoInfo.title,
                            style: TextStyle(fontSize: 20, color: Colors.grey,),
                          ),
                        ]
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 10),),
                Container(
                  child: Text.rich(
                    TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Ссылка на картинку: ",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),
                          ),
                          TextSpan(
                            text: photoInfo.url,
                            style: TextStyle(fontSize: 20, color: Colors.grey,),
                          ),
                        ]
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 30),),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.blue) ),
                  onPressed: () => Navigator.pop(context),
                  child: Text('НАЗАД', style: TextStyle(fontSize: 25, color: Colors.white,),),
                )
              ],
            ),
          ],
        )
      )
    );
  }
}
