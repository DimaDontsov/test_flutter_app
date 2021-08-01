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