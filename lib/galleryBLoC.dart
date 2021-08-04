import 'dart:async';
import 'dart:convert';
import 'dart:io';
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

class GalleryResult {

  List<Photo> photos = [];
  String errorMessage = '';

  GalleryResult();

  GalleryResult.success(photos) {
    this.photos = photos;
  }

  GalleryResult.error(errorMessage) {
    this.errorMessage = errorMessage;
  }

  bool isSuccess() {
    return this.errorMessage.isEmpty;
  }
}

enum GalleryEvent {
  refresh,
}

class GalleryBloc extends Bloc<GalleryEvent, GalleryResult> {
  /// {@macro counter_bloc}
  GalleryBloc() : super(GalleryResult());

  List<Photo> _photos = [];

  void getPhotoList() async {

    Repository repo = new Repository();
    List<Photo> photos = [];

    try {
      var photoList = await repo.fetchPhotos();
      photos = photoList.photos;

    } catch (error) {
      throw error;
    }
    _photos = photos;
  }

  @override
  Stream<GalleryResult> mapEventToState(GalleryEvent event) async* {
    try {
      switch (event) {
        case GalleryEvent.refresh:
          yield GalleryResult(); // Для того, чтобы после нажатия на кнопку появлялась иконка загрузки
          await Future.delayed(Duration(milliseconds: 2000), () => getPhotoList());
          yield GalleryResult.success(_photos);
          break;
      }
    } on SocketException {
      yield GalleryResult.error('Ошибка загрузки. Проверьте подключение к сети и повторите попытку.');
    }
    catch (error) {
      yield GalleryResult.error(error.toString());
    }
  }
}


