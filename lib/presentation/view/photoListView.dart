import 'package:flutter/cupertino.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/presentation/view/photoCardView.dart';

class PhotoListView extends StatelessWidget {
  final List<NasaPhoto> photos;

  PhotoListView(this.photos);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: photos.length,
        itemBuilder: (BuildContext context, int index) {
          return PhotoCardView(photos[index]);
        });
  }
}
