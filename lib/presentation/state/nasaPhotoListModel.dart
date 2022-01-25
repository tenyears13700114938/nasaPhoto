import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_nasa_photo/core/usecases/usecase.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';
import 'package:flutter_nasa_photo/domain/usecases/getPhotosUseCase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entites/nasaPhoto.dart';
import 'package:intl/intl.dart';

final nasaPhotoListModelProvider =
    StateNotifierProvider<NasaPhotoListModel, AsyncValue<List<NasaPhoto>>>(
        (ref) {
  return NasaPhotoListModel(GetPhotosUseCase());
});

class NasaPhotoListModel extends StateNotifier<AsyncValue<List<NasaPhoto>>> {
  final GetPhotosUseCase _getPhotoUseCase;

  NasaPhotoListModel(this._getPhotoUseCase) : super(AsyncValue.loading()) {
    loadPhotos();
  }

  void loadPhotos() async {
    state = await AsyncValue.guard(() {
      return _getPhotoUseCase.call(List.empty());
    });
  }

  void loadMoreNewPhotos() async {
    DateTime currentTime =
        DateTime.parse(state.value?.first.date ?? DateTime.now().toString())
            .add(Duration(days: 1));
    DateTime now = DateTime.now();
    DateTime resetBellowDay = DateTime(now.year, now.month, now.day);
    if (currentTime.isBefore(resetBellowDay)) {
      state = await AsyncValue.guard(() {
        List<NasaPhoto> photos = List.from(state.value ?? List.empty());
        return _getPhotoUseCase.call([
          DateFormat("yyyy-MM-dd").format(currentTime),
          DateFormat("yyyy-MM-dd").format(resetBellowDay)
        ]).then((value) {
          photos.insertAll(0, value);
          return photos;
        });
      });
    }
  }

  Future<void> loadMoreOldPhotos() async {
    String? lastDate = state.value?.last.date;
    if (lastDate != null) {
      DateTime startTime = DateTime.parse(lastDate).add(Duration(days: -21));
      DateTime endTime = DateTime.parse(lastDate).add(Duration(days: -1));

      List<NasaPhoto> photos = List.from(state.value ?? List.empty());

      state = await AsyncValue.guard(() {
        return _getPhotoUseCase.call([
          DateFormat("yyyy-MM-dd").format(startTime),
          DateFormat("yyyy-MM-dd").format(endTime)
        ]).then((value) {
          photos.addAll(value);
          return photos;
        });
      });
    }
  }
}
