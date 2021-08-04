import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

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



enum GalleryEvent {
  refresh,
}

class GalleryBloc extends Bloc<GalleryEvent, List<Photo>> {
  /// {@macro counter_bloc}
  GalleryBloc() : super([]);

  List<Photo> _photos = [];

  void getPhotoList() async {

    Repository repo = new Repository();
    List<Photo> photos = [];

    try {
      var photoList = await repo.fetchPhotos();
      photos = photoList.photos;

    } catch (error) {
      print(error);
    }
    _photos = photos;
  }

  @override
  Stream<List<Photo>> mapEventToState(GalleryEvent event) async* {
    switch (event) {
      case GalleryEvent.refresh:
        yield []; // Для того, чтобы после нажатия на кнопку появлялась иконка загрузки
        await Future.delayed(Duration(milliseconds: 2000), () => getPhotoList());
        yield _photos;
        break;
    }
  }
}


