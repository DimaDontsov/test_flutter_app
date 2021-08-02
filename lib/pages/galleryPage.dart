import 'package:flutter/material.dart';
import 'package:test_flutter_app/widgets/myAppBar.dart';
import 'package:test_flutter_app/widgets/myDrawer.dart';
import 'package:test_flutter_app/photo.dart';
import 'package:test_flutter_app/galleryBLoC.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class MyGridList extends StatelessWidget {

  GalleryBloc galleryBloc;

  MyGridList({Key? key, required this.galleryBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: galleryBloc.pressedRefresh,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Photo> images = snapshot.data as List<Photo>;
            if (images.length == 0) {
              return Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    "Ошибка загрузки. Проверьте подключение к сети и повторите проверку.",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            List<Widget> categories = [];
            for (int shift = 0, caterogyNum = 1; caterogyNum <= 4; caterogyNum++, shift += 6) {
              categories.addAll([
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Категория №$caterogyNum", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black,),),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: StaggeredGridView.countBuilder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    // количество изображений
                    itemCount: 6,
                    // crossAxisCount задает количество колонок
                    // по которым будут выравнены изображения
                    crossAxisCount: 2,
                    // отступы по вертикали
                    mainAxisSpacing: 20,
                    // отступы по горизонтали
                    crossAxisSpacing: 20,
                    staggeredTileBuilder: (index) {
                      return StaggeredTile.count(1, 1);
                    },
                    // строим изображение
                    itemBuilder: (context, index) {
                      index += shift;
                      return Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/photo_detail', arguments: images[index]);
                            },
                            child:  Image.network(
                              images[index].url,
                              // указываем максимальную ширину и высоту
                              width: 600,
                              height: 600,
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
                          )
                      );
                    },
                  ),
                ),
              ]);
            }

            return ListView(
              children: categories,
            );

          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }
}



class GalleryPage extends StatefulWidget {
  GalleryPage({Key? key}) : super(key: key);

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {

  GalleryBloc galleryBloc = GalleryBloc();

  @override
  void initState() {
    galleryBloc.refreshGallery.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(titleText: 'Галерея',),
      drawer: MyDrawer(),
      body: MyGridList(galleryBloc: galleryBloc,),
      floatingActionButton: Container(
        // width: 100.0,
        // height: 100.0,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            galleryBloc.refreshGallery.add(null);
          },
          child: Icon(
            Icons.refresh, color: Colors.white,
          )
        ),
      ),
    );
  }

}


