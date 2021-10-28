import 'package:equatable/equatable.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';

class NasaPhotoModel implements Equatable {
  final String copyright;
  final String date;
  final String explanation;
  final String hdUrl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;
  final int bookMarkType;

  NasaPhotoModel(
      {this.date = "",
      this.explanation = "",
      this.hdUrl = "",
      this.mediaType = "",
      this.serviceVersion = "",
      this.title = "",
      this.url = "",
      this.copyright = "",
      this.bookMarkType = 0});

  factory NasaPhotoModel.fromJson(Map<String, dynamic> json) {
    return NasaPhotoModel(
        date: json['date'],
        copyright: json['copyright'],
        explanation: json['explanation'],
        hdUrl: json['hdurl'],
        mediaType: json['media_type'],
        serviceVersion: json['service_version'],
        title: json['title'],
        url: json['url']);
  }

  factory NasaPhotoModel.fromMap(Map<String, dynamic> map) {
    return NasaPhotoModel(
        date: map['date'],
        explanation: map['explanation'],
        mediaType: map['media_type'],
        title: map['title'],
        url: map['url'],
        bookMarkType: map['book_mark_type']);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'url': url,
      'title': title,
      'media_type': mediaType,
      'explanation': explanation,
      'book_mark_type': bookMarkType,
    };
  }

  NasaPhotoModel.fromEntity(NasaPhoto photo)
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

  @override
  bool? get stringify => true;
}
