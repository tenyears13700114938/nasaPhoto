import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoBookMarkListModel.dart';
import 'package:flutter_nasa_photo/presentation/view/photoListView.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoBookMarkScreen extends ConsumerStatefulWidget {
  _PhotoBookMarkScreenState createState() => _PhotoBookMarkScreenState();

  static MaterialPage createPage() {
    return MaterialPage(
        key: ValueKey('bookMarkScreen'), child: PhotoBookMarkScreen());
  }
}

class _PhotoBookMarkScreenState extends ConsumerState<PhotoBookMarkScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(nasaPhotoBookMarkListModelProvider);
  }

  @override
  Widget build(BuildContext context) {
    AsyncValue<List<NasaPhoto>> photos =
        ref.watch(nasaPhotoBookMarkListModelProvider);
    return photos.when(
        data: (photoData) {
          return PhotoListView(photoData);
        },
        error: (obj, trace) {
          return AlertDialog(
            title: const Text("load error..."),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
