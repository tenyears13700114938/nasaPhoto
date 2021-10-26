import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/model/nasaPhoto.dart';
import 'package:flutter_nasa_photo/repository/dataBaseRepository.dart';
import 'package:flutter_nasa_photo/repository/webRepository.dart';
import 'package:intl/intl.dart';

abstract class NasaRepository {
  void init();

  Future<List<NasaPhoto>> loadPhotos(
      {String startDate = "", String endDate = ""});

  Future<List<NasaPhoto>> loadBookmarkPhotos();

  Future<void> updatePhoto(NasaPhoto photo);
}

class MyRepository implements NasaRepository {
  late DatabaseRepository databaseRepository;
  late WebRepository webRepository;

  MyRepository._() {
    databaseRepository = DatabaseRepository();
    webRepository = WebRepository();
    init();
  }

  static final MyRepository _repository = MyRepository._();

  factory MyRepository() {
    return _repository;
  }

  @override
  void init() {
    databaseRepository.init();
    webRepository.init();
  }

  @override
  Future<List<NasaPhoto>> loadPhotos(
      {String startDate = "", String endDate = ""}) async {
    List<NasaPhoto> result = List.empty();
    if (startDate == "") result = await databaseRepository.loadPhotos();

    if (result.isEmpty) {
      if (startDate == "") {
        DateTime endTime = DateTime.now();
        DateTime startTime = endTime.add(Duration(days: -20));
        startDate = DateFormat("yyyy-MM-dd").format(startTime);
        endDate = DateFormat("yyyy-MM-dd").format(endTime);
        endDate = "2021-10-12";
      }
      result = await webRepository.loadPhotos(
          startDate: startDate, endDate: endDate);
      result = result.reversed.toList();
      await databaseRepository.insertPhoto(result);
    }
    return result;
  }

  @override
  Future<List<NasaPhoto>> loadBookmarkPhotos() async {
    List<NasaPhoto> result = List.empty();
    result = await databaseRepository.loadBookmarkPhotos();
    return result;
  }

  @override
  Future<void> updatePhoto(NasaPhoto photo) async {
    await databaseRepository.updatePhoto(photo);
  }
}

class TestRepository implements NasaRepository {
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
  Future<Void> updatePhoto(NasaPhoto phto) {
    // TODO: implement updatePhoto
    throw UnimplementedError();
  }
}
