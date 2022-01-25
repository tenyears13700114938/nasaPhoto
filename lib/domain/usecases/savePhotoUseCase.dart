import 'package:flutter_nasa_photo/core/usecases/usecase.dart';
import 'package:flutter_nasa_photo/data/repositories/myRepository.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';

class SavePhotoUseCase implements UseCase<void, NasaPhoto> {
  NasaRepository _repository;

  SavePhotoUseCase._(this._repository);

  static final SavePhotoUseCase _savePhotoUseCase =
      SavePhotoUseCase._(MyRepository());

  factory SavePhotoUseCase() {
    return _savePhotoUseCase;
  }

  @override
  Future<void> call(NasaPhoto params) {
    return _repository.updatePhoto(params);
  }
}
