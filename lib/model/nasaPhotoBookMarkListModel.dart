import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter_nasa_photo/repository/nasaRepository.dart';

import 'nasaPhoto.dart';

class NasaPhotoBookMarkListModel extends ChangeNotifier {
  final NasaRepository repository;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NasaPhoto> _photos = List.empty(growable: true);

  UnmodifiableListView<NasaPhoto> get photos => UnmodifiableListView(_photos);

  NasaPhotoBookMarkListModel(this.repository);

  Future loadingBookmark() {
    _isLoading = true;
    return repository.loadBookmarkPhotos().then((bookmarks) {
      _photos.addAll(bookmarks);
      _isLoading = false;
      notifyListeners();
    }).catchError((error) {
      _isLoading = false;
      notifyListeners();
    });
  }
}
