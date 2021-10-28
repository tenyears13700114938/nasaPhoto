import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_nasa_photo/core/usecases/usecase.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';
import 'package:flutter_nasa_photo/domain/usecases/getPhotosUseCase.dart';

import '../../domain/entites/nasaPhoto.dart';
import 'package:intl/intl.dart';

class NasaPhotoListModel extends ChangeNotifier {
  final GetPhotosUseCase _getPhotoUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NasaPhoto> _photos = List.empty(growable: true);

  UnmodifiableListView<NasaPhoto> get photos => UnmodifiableListView(_photos);

  NasaPhotoListModel(this._getPhotoUseCase);

  Future loadPhotos() {
    _isLoading = true;
    notifyListeners();

    return _getPhotoUseCase.call(List.empty()).then((loadPhotos) {
      _photos.addAll(loadPhotos);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void loadMoreNewPhotos() {
    DateTime currentTime =
        DateTime.parse(_photos.first.date).add(Duration(days: 1));
    DateTime now = DateTime.now();
    DateTime resetBellowDay = DateTime(now.year, now.month, now.day);
    if (currentTime.isBefore(resetBellowDay)) {
      _isLoading = true;
      notifyListeners();

      _getPhotoUseCase.call([
        DateFormat("yyyy-MM-dd").format(currentTime),
        DateFormat("yyyy-MM-dd").format(resetBellowDay)
      ]).then((value) {
        _photos.insertAll(0, value);
        _isLoading = false;
        notifyListeners();
      }).catchError((error) {
        _isLoading = false;
        notifyListeners();
      });
    }
  }

  void loadMoreOldPhotos() {
    DateTime startTime =
        DateTime.parse(_photos.last.date).add(Duration(days: -21));
    DateTime endTime =
        DateTime.parse(_photos.last.date).add(Duration(days: -1));

    _isLoading = true;
    notifyListeners();

    _getPhotoUseCase.call([
      DateFormat("yyyy-MM-dd").format(startTime),
      DateFormat("yyyy-MM-dd").format(endTime)
    ]).then((value) {
      _photos.addAll(value);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
  }
}
