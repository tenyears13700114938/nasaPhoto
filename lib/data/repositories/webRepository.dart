import 'dart:ffi';

import 'package:flutter_nasa_photo/data/models/nasaPhotoModel.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//val appKey = "Mckqw9rQyHoPMYBJG7Gvf0lcxH9DeGhzv2lZdnqT"
//
class WebRepository implements NasaRepository {
  WebRepository._();

  static final WebRepository _repository = WebRepository._();

  factory WebRepository() {
    return _repository;
  }

  @override
  Future<List<NasaPhoto>> loadPhotos(
      {String startDate = "", String endDate = ""}) async {
    print("load photos from web startDate $startDate endDate $endDate.....");
    String testUrl =
        "https://api.nasa.gov/planetary/apod?api_key=Mckqw9rQyHoPMYBJG7Gvf0lcxH9DeGhzv2lZdnqT&start_date=$startDate&end_date=$endDate";
    final response = await http.get(Uri.parse(testUrl));
    if (response.statusCode == 200) {
      List<NasaPhoto> photoList = (jsonDecode(response.body) as List)
          .map((e) => NasaPhoto.fromModel(NasaPhotoModel.fromJson(e)))
          .toList();
      return photoList;
    } else {
      return List.empty();
    }
  }

  @override
  void init() {
    // TODO: implement init
  }

  @override
  Future<List<NasaPhoto>> loadBookmarkPhotos() {
    // TODO: implement loadBookmarkPhotos
    throw UnimplementedError();
  }

  @override
  Future<Void> updatePhoto(NasaPhoto phto) {
    // TODO: implement updatePhoto
    throw UnimplementedError();
  }
}
