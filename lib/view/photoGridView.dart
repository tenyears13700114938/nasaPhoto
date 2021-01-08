
import 'package:flutter/cupertino.dart';
import 'package:flutter_nasa_photo/model/nasaPhotoListModel.dart';
import 'package:flutter_nasa_photo/repository/nasaRepository.dart';
import 'package:flutter_nasa_photo/view/photoItemView.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PhotoGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Consumer<NasaPhotoListModel>(
      builder: (context, photoList, child){
        return GestureDetector(
          onVerticalDragDown: (e){
            if(controller.offset == controller.position.maxScrollExtent){
              Provider.of<NasaPhotoListModel>(context, listen: false).loadMoreOldPhotos();
            } else if(controller.offset == controller.position.minScrollExtent) {
              Provider.of<NasaPhotoListModel>(context, listen: false).loadMoreNewPhotos();
            }
          },
          onTap: (){
            print("test onTap....");
            print("test ${DateTime.parse("2021-01-05")}");
            print("test ${DateFormat("yyyy-MM-dd").format(DateTime.now())}");
          },
          child: GridView.builder(
            itemBuilder: (context, position){
              final photo = photoList.photos[position];
              return PhotoItemView(photo.url, photo.title, photo.date);
            },
            itemCount: photoList.photos.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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

  List<Widget> toWidgetList(NasaPhotoListModel model){
    return model.photos.map((e) =>
      PhotoItemView(e.url, e.title, e.date)
    ).toList();
  }
}