import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';

abstract class NasaRepository {
  void init();

  Future<List<NasaPhoto>> loadPhotos(
      {String startDate = "", String endDate = ""});

  Future<List<NasaPhoto>> loadBookmarkPhotos();

  Future<void> updatePhoto(NasaPhoto photo);
}
