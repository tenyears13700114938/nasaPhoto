import 'package:flutter_nasa_photo/data/repositories/webRepository.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';
import 'package:intl/intl.dart';

import 'dataBaseRepository.dart';

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
        endDate = "2022-01-21";
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
