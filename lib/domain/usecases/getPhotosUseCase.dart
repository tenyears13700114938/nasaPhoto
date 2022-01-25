import 'package:flutter_nasa_photo/core/usecases/usecase.dart';
import 'package:flutter_nasa_photo/data/repositories/myRepository.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';

class GetPhotosUseCase implements UseCase<List<NasaPhoto>, List<String>> {
  final NasaRepository _repository;

  GetPhotosUseCase._(this._repository);

  static final GetPhotosUseCase _getPhotosUseCase =
      GetPhotosUseCase._(MyRepository());

  factory GetPhotosUseCase() {
    return _getPhotosUseCase;
  }

  @override
  Future<List<NasaPhoto>> call(List<String> params) {
    if (params.length < 2) {
      return _repository.loadPhotos();
    } else {
      return _repository.loadPhotos(
          startDate: params.elementAt(0), endDate: params.elementAt(1));
    }
  }
}
