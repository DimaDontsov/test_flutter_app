import 'package:flutter/material.dart';
import 'package:test_flutter_app/widgets/myAppBar.dart';
import 'package:test_flutter_app/widgets/myDrawer.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const String SERVER = "https://jsonplaceholder.typicode.com/photos";

class Repository {


  // обработку ошибок мы сделаем в контроллере
  // мы возвращаем Future объект, потому что
  // fetchPhotos асинхронная функция
  // асинхронные функции не блокируют UI
  Future<PhotoList> fetchPhotos() async {
    // сначала создаем URL, по которому
    // мы будем делать запрос
    final url = Uri.parse(SERVER);
    // делаем GET запрос
    final response = await http.get(url);
// проверяем статус ответа
    if (response.statusCode == 200) {
      // если все ок то возвращаем посты
      // json.decode парсит ответ
      return PhotoList.fromJson(json.decode(response.body));
    } else {
      // в противном случае говорим об ошибке
      throw Exception("failed request");
    }

  }
}


class Photo {

  final int _albumId;
  final int _id;
  final String _title;
  final String _url;

  int get albumId => _albumId;
  int get id => _id;
  String get title => _title;
  String get url => _url;

  Photo.fromJson(Map<String, dynamic> json) :
        this._albumId = json["albumId"],
        this._id = json["id"],
        this._title = json["title"],
        this._url = json["url"];

}

class PhotoList {
  List<Photo> photos = [];
  PhotoList.fromJson(List<dynamic> jsonItems) {
    for (var jsonItem in jsonItems) {
      photos.add(Photo.fromJson(jsonItem));
    }
  }
  PhotoList(){}
}


class MyGridList extends StatefulWidget {
  const MyGridList({Key? key}) : super(key: key);

  @override
  _MyGridListState createState() => _MyGridListState();
}

class _MyGridListState extends State<MyGridList> {

  Repository repo = new Repository();
  List<Photo> photos = [];

  Future<List<Photo>> callAsyncFetch() => Future.delayed(Duration(milliseconds: 500), () => getPhotoList());

  Future<List<Photo>> getPhotoList() async {

    List<Photo> photos = [];

    try {
      var photoList = await repo.fetchPhotos();
      photos = photoList.photos;

    } catch (error) {
      print(error);
    }
    return photos;
  }

  @override
  void initState() {
    super.initState();
    // получаем картинки из JSONPlaceholder
    getPhotoList().then((value) => photos = value);
    print("Hello");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Photo>>(
        future: callAsyncFetch(),
        builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
          if (snapshot.hasData) {
            var images = photos;
            // мы используем StaggeredGridView для построения
            // кастомной сетки из изображений
            return StaggeredGridView.countBuilder(
              // количество изображений
              itemCount: 6,
              // crossAxisCount задает количество колонок
              // по которым будут выравнены изображения
              crossAxisCount: 2,
              // отступы по вертикали
              mainAxisSpacing: 10,
              // отступы по горизонтали
              crossAxisSpacing: 10,
              staggeredTileBuilder: (index) {
                return StaggeredTile.count(1, 1);
              },
              // строим изображение
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pinkAccent, width: 1)
                  ),
                  // мы используем метод Image.network для
                  // отображения картинок из сети
                  child: Image.network(
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
                );
              },

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


