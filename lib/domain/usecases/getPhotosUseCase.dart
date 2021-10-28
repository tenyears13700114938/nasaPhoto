import 'package:flutter_nasa_photo/core/usecases/usecase.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/domain/repositories/nasaRepository.dart';

class GetPhotosUseCase implements UseCase<List<NasaPhoto>, List<String>> {
  final NasaRepository _repository;

  GetPhotosUseCase(this._repository);

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
