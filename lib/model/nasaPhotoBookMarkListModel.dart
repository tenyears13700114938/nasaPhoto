import 'dart:collection';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_nasa_photo/repository/nasaRepository.dart';

import 'nasaPhoto.dart';

class NasaPhotoBookMarkListModel extends ChangeNotifier implements Equatable {
  final NasaRepository repository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NasaPhoto> _photos = List.empty(growable: true);

  UnmodifiableListView<NasaPhoto> get photos => UnmodifiableListView(_photos);

  NasaPhotoBookMarkListModel(this.repository);

  Future loadingBookmark() {
    _isLoading = true;
    log("debug begin loading...");
    return repository.loadBookmarkPhotos().then((bookmarks) {
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
    return repository.updatePhoto(photo);
  }

  @override
  List<Object?> get props => [_isLoading, _photos];

  @override
  bool? get stringify => false;
}
