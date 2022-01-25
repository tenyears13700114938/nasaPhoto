import 'package:flutter_nasa_photo/core/usecases/usecase.dart';
import 'package:flutter_nasa_photo/data/repositories/myRepository.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';

class GetBookmarkUseCase implements UseCase<List<NasaPhoto>, void> {
  final NasaRepository _repository;

  GetBookmarkUseCase._(this._repository);

  static final GetBookmarkUseCase _getBookmarkUseCase =
      GetBookmarkUseCase._(MyRepository());

  factory GetBookmarkUseCase() {
    return _getBookmarkUseCase;
  }

  @override
  Future<List<NasaPhoto>> call(void params) {
    return _repository.loadBookmarkPhotos();
  }
}
