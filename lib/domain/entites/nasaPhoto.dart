import 'package:equatable/equatable.dart';
import 'package:flutter_nasa_photo/data/models/nasaPhotoModel.dart';

class NasaPhoto extends Equatable {
  final String copyright;
  final String date;
  final String explanation;
  final String hdUrl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;
  final int bookMarkType;

  NasaPhoto(
      {this.date = "",
      this.explanation = "",
      this.hdUrl = "",
      this.mediaType = "",
      this.serviceVersion = "",
      this.title = "",
      this.url = "",
      this.copyright = "",
      this.bookMarkType = 0});

  NasaPhoto.fromModel(NasaPhotoModel photo)
      : copyright = photo.copyright,
        date = photo.date,
        explanation = photo.explanation,
        hdUrl = photo.hdUrl,
        mediaType = photo.mediaType,
        serviceVersion = photo.serviceVersion,
        title = photo.title,
        url = photo.url,
        bookMarkType = photo.bookMarkType;

  @override
  List<Object?> get props =>
      [date, url, title, mediaType, explanation, bookMarkType];
}
