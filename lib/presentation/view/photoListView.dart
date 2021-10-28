import 'package:flutter/cupertino.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoBookMarkListModel.dart';
import 'package:flutter_nasa_photo/presentation/view/photoCardView.dart';
import 'package:provider/provider.dart';

class PhotoListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NasaPhotoBookMarkListModel>(
        builder: (context, bookmarkList, child) {
      return ListView.builder(
          itemCount: bookmarkList.photos.length,
          itemBuilder: (BuildContext context, int index) {
            return PhotoCardView(bookmarkList.photos[index]);
          });
    });
  }
}
