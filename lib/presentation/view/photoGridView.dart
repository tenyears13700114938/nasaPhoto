import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoListModel.dart';
import 'package:flutter_nasa_photo/presentation/screen/photoDetailScreen.dart';
import 'package:flutter_nasa_photo/presentation/view/photoItemView.dart';
import 'package:provider/provider.dart';

class PhotoGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //PaintingBinding.instance.imageCache.clear();
    ScrollController controller = ScrollController();
    return Consumer<NasaPhotoListModel>(
      builder: (context, photoList, child) {
        return GestureDetector(
          onVerticalDragDown: (e) {
            if (controller.offset == controller.position.maxScrollExtent) {
              Provider.of<NasaPhotoListModel>(context, listen: false)
                  .loadMoreOldPhotos();
            } else if (controller.offset ==
                controller.position.minScrollExtent) {
              Provider.of<NasaPhotoListModel>(context, listen: false)
                  .loadMoreNewPhotos();
            }
          },
          child: GridView.builder(
            itemBuilder: (context, position) {
              final photo = photoList.photos[position];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PhotoDetailScreen(photo)));
                },
                child: PhotoItemView(photo.url, photo.title, photo.date),
              );
            },
            itemCount: photoList.photos.length,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
          ),
          // child: GridView.count(
          //   primary: false,
          //   padding: const EdgeInsets.all(20),
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          //   crossAxisCount: 2,
          //   children: toWidgetList(photoList),
          //   controller: controller,
          // ),
        );
      },
    );
  }

  List<Widget> toWidgetList(NasaPhotoListModel model) {
    return model.photos
        .map((e) => PhotoItemView(e.url, e.title, e.date))
        .toList();
  }
}
