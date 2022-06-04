import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';

abstract class NasaPhotoRoute {}

class NasaPhotoGrid extends NasaPhotoRoute {}

class NasaPhotoDetail extends NasaPhotoRoute {
  final NasaPhoto detailPhoto;

  NasaPhotoDetail(this.detailPhoto);
}

class NasaPhotoBookmark extends NasaPhotoRoute {}

class NasaPhotoTheme extends NasaPhotoRoute {}

class LogIn extends NasaPhotoRoute {}

class Home extends NasaPhotoRoute {}

class NasaPhotoUnknown extends NasaPhotoRoute {}
