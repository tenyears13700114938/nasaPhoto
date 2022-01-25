import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoListModel.dart';
import 'package:flutter_nasa_photo/presentation/view/photoGridView.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoGridScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<NasaPhoto>> photos = ref.watch(nasaPhotoListModelProvider);
    return photos.when(data: (photoData) {
      return PhotoGridView(photoData);
    }, error: (obj, trace) {
      return AlertDialog(
        title: const Text("load error..."),
      );
    }, loading: () {
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
