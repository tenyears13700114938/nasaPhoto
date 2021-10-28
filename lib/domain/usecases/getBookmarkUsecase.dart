import 'package:flutter_nasa_photo/core/usecases/usecase.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';

class GetBookmarkUseCase implements UseCase<List<NasaPhoto>, void> {
  final NasaRepository _repository;

  GetBookmarkUseCase(this._repository);

  @override
  Future<List<NasaPhoto>> call(void params) {
    return _repository.loadBookmarkPhotos();
  }
}
