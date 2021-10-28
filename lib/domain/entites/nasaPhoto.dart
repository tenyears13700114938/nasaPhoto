
import 'package:equatable/equatable.dart';

class NasaPhoto extends Equatable {
  final String copyright;
  final String date;
  final String explanation;
  final String hdUrl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;
  int bookMarkType;

  NasaPhoto({this.date = "",
    this.explanation = "",
    this.hdUrl = "",
    this.mediaType = "",
    this.serviceVersion = "",
    this.title = "",
    this.url = "",
    this.copyright = "",
  this.bookMarkType = 0});

  // @override
  // int get hashCode => date.hashCode ^ explanation.hashCode ^ hdUrl.hashCode ^ mediaType.hashCode
  // ^ serviceVersion.hashCode ^ title.hashCode ^ url.hashCode ^ copyright.hashCode;
  //
  // @override
  // bool operator ==(Object other) {
  //   return identical(this, other) ||
  //     other is NasaPhoto &&
  //     date == other.date &&
  //     explanation == other.explanation &&
  //     hdUrl == other.hdUrl &&
  //     mediaType == other.mediaType &&
  //     serviceVersion == other.serviceVersion &&
  //     title == other.title &&
  //     copyright == other.copyright;
  // }
  //
  // @override
  // String toString() {
  //   return 'nasaPhoto{date: $date, explanation: $explanation, hdUrl: $hdUrl, mediaType:$mediaType, serviceVersion: $serviceVersion, title: $title, copyright: $copyright}';
  // }

  factory NasaPhoto.fromJson(Map<String, dynamic> json){
    return NasaPhoto(
      date: json['date'],
      copyright: json['copyright'],
      explanation: json['explanation'],
      hdUrl: json['hdurl'],
      mediaType: json['media_type'],
      serviceVersion: json['service_version'],
      title: json['title'],
      url: json['url']
    );
  }

  factory NasaPhoto.fromMap(Map<String, dynamic> map){
    return NasaPhoto(
      date: map['date'],
      explanation: map['explanation'],
      mediaType: map['media_type'],
      title: map['title'],
      url: map['url'],
      bookMarkType: map['book_mark_type']
    );
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

  @override
  List<Object?> get props => [date, url, title, mediaType, explanation, bookMarkType];
}