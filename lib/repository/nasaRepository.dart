
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/model/nasaPhoto.dart';
import 'package:flutter_nasa_photo/repository/dataBaseRepository.dart';
import 'package:flutter_nasa_photo/repository/webRepository.dart';
import 'package:intl/intl.dart';

abstract class NasaRepository{
  void init();
  Future<List<NasaPhoto>> loadPhotos({String startDate = "", String endDate = ""});
}

class MyRepository implements NasaRepository {
  final DatabaseRepository databaseRepository;
  final WebRepository webRepository;

  MyRepository(this.databaseRepository, this.webRepository);

  @override
  void init() {
    databaseRepository.init();
    webRepository.init();
  }

  @override
  Future<List<NasaPhoto>> loadPhotos({String startDate = "", String endDate = ""}) async {
    List<NasaPhoto> result = List.empty();
    if(startDate == "") result = await databaseRepository.loadPhotos();

    if(result.isEmpty){
      if(startDate == "") {
        DateTime endTime = DateTime.now();
        DateTime startTime = endTime.add(Duration(days: -20));
        startDate = DateFormat("yyyy-MM-dd").format(startTime);
        endDate = DateFormat("yyyy-MM-dd").format(endTime);
        endDate = "2021-10-12";
      }
      result = await webRepository.loadPhotos(startDate: startDate, endDate: endDate);
      result = result.reversed.toList();
      await databaseRepository.insertPhoto(result);
    }
    return result;
  }

}

class TestRepository implements NasaRepository {
  @override
  Future<List<NasaPhoto>> loadPhotos({String startDate = "", String endDate = ""}) {
    List<NasaPhoto> photoList = List.filled(15, NasaPhoto()
    );
    for(var i = 0; i < 15; i++){
      photoList[i] = NasaPhoto(title: 'hello photo nasa world and hello photo nasa world $i',
        url: 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
      );
    }
    return Future.value(photoList);
  }

  @override
  void init() {
  }
}