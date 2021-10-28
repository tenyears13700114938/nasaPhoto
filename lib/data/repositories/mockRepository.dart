import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';

class MockRepository implements NasaRepository {
  @override
  Future<List<NasaPhoto>> loadPhotos(
      {String startDate = "", String endDate = ""}) {
    List<NasaPhoto> photoList = List.filled(15, NasaPhoto());
    for (var i = 0; i < 15; i++) {
      photoList[i] = NasaPhoto(
          title: 'hello photo nasa world and hello photo nasa world $i',
          url:
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg');
    }
    return Future.value(photoList);
  }

  @override
  void init() {}

  @override
  Future<List<NasaPhoto>> loadBookmarkPhotos() {
    // TODO: implement loadBookmarkPhotos
    throw UnimplementedError();
  }

  @override
  Future<void> updatePhoto(NasaPhoto phto) {
    // TODO: implement updatePhoto
    throw UnimplementedError();
  }
}
