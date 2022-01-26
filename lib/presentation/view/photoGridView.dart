import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoListModel.dart';
import 'package:flutter_nasa_photo/presentation/screen/photoDetailScreen.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoRouteState.dart';
import 'package:flutter_nasa_photo/presentation/view/photoItemView.dart';
import 'package:flutter_nasa_photo/route/nasaPhotoRoute.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoGridView extends ConsumerWidget {
  final List<NasaPhoto> photoList;

  PhotoGridView(this.photoList);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //PaintingBinding.instance.imageCache.clear();
    ScrollController controller = ScrollController();
    return GestureDetector(
      onVerticalDragDown: (e) {
        if (controller.offset == controller.position.maxScrollExtent) {
          ref.read(nasaPhotoListModelProvider.notifier).loadMoreOldPhotos();
        } else if (controller.offset == controller.position.minScrollExtent) {
          ref.read(nasaPhotoListModelProvider.notifier).loadMoreNewPhotos();
        }
      },
      child: GridView.builder(
        itemBuilder: (context, position) {
          final photo = photoList[position];
          return GestureDetector(
            onTap: () {
              ref.read(nasaPhotoRouteStateProvider).push(NasaPhotoDetail(photo));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => PhotoDetailScreen(photo)));
            },
            child: PhotoItemView(photo.url, photo.title, photo.date),
          );
        },
        itemCount: photoList.length,
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
  }

  List<Widget> _toWidgetList() {
    return photoList.map((e) => PhotoItemView(e.url, e.title, e.date)).toList();
  }
}
