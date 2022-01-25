import 'package:flutter_nasa_photo/domain/usecases/getBookmarkUsecase.dart';
import 'package:flutter_nasa_photo/domain/usecases/savePhotoUseCase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entites/nasaPhoto.dart';

final nasaPhotoBookMarkListModelProvider = StateNotifierProvider<
    NasaPhotoBookMarkListModel, AsyncValue<List<NasaPhoto>>>((ref) {
  return NasaPhotoBookMarkListModel(GetBookmarkUseCase(), SavePhotoUseCase());
});

class NasaPhotoBookMarkListModel
    extends StateNotifier<AsyncValue<List<NasaPhoto>>> {
  final GetBookmarkUseCase _getBookmarkUseCase;
  final SavePhotoUseCase _savePhotoUseCase;

  NasaPhotoBookMarkListModel(this._getBookmarkUseCase, this._savePhotoUseCase)
      : super(AsyncValue.loading()) {
    loadingBookmark();
  }

  void loadingBookmark() async {
    state = await AsyncValue.guard(() {
      return _getBookmarkUseCase.call(null);
    });
  }

  void updateBookmark(NasaPhoto photo) async {
    List<NasaPhoto> photos = List.from(state.value ?? List.empty());
    state = await AsyncValue.guard(() {
      _savePhotoUseCase.call(photo);
      photos.add(photo);
      return Future.value(photos);
    });
  }
}
