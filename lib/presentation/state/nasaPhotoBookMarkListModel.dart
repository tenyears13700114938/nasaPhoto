import 'dart:collection';
import 'dart:developer';
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';
import 'package:flutter_nasa_photo/domain/usecases/getBookmarkUsecase.dart';
import 'package:flutter_nasa_photo/domain/usecases/savePhotoUseCase.dart';

import '../../domain/entites/nasaPhoto.dart';

class NasaPhotoBookMarkListModel extends ChangeNotifier implements Equatable {
  final GetBookmarkUseCase _getBookmarkUseCase;
  final SavePhotoUseCase _savePhotoUseCase;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NasaPhoto> _photos = List.empty(growable: true);

  UnmodifiableListView<NasaPhoto> get photos => UnmodifiableListView(_photos);

  NasaPhotoBookMarkListModel(this._getBookmarkUseCase, this._savePhotoUseCase);

  Future loadingBookmark() {
    _isLoading = true;
    log("debug begin loading...");
    return _getBookmarkUseCase.call(null).then((bookmarks) {
      _photos.clear();
      _photos.addAll(bookmarks);
      _isLoading = false;
      log("debug load end...");
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Future updateBookmark(NasaPhoto photo) {
    return _savePhotoUseCase.call(photo);
  }

  @override
  List<Object?> get props => [_isLoading, _photos];

  @override
  bool? get stringify => false;
}
