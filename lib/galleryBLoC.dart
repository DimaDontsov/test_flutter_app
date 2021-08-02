import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:test_flutter_app/photo.dart';

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

class GalleryBloc {

  GalleryBloc() {
    _actionController.stream.listen(_refreshStream);
  }

  final StreamController<List<Photo>> _refreshController = StreamController<List<Photo>>();

  Stream get pressedRefresh => _refreshController.stream;
  Sink get _addPhotos => _refreshController.sink;

  StreamController _actionController = StreamController();
  StreamSink get refreshGallery => _actionController.sink;

  void _refreshStream (data) async {
    _addPhotos.add(null); // Для того, чтобы после нажатия на кнопку появлялась иконка загрузки
    await Future.delayed(Duration(milliseconds: 2000), () => getPhotoList());
  }

  void getPhotoList() async {

    Repository repo = new Repository();
    List<Photo> photos = [];

    try {
      var photoList = await repo.fetchPhotos();
      photos = photoList.photos;

    } catch (error) {
      print(error);
    }
    _addPhotos.add(photos);
  }

  void dispose() {
    _refreshController.close();
    _actionController.close();
  }

}

