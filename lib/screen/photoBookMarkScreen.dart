import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/model/nasaPhotoBookMarkListModel.dart';
import 'package:flutter_nasa_photo/view/photoListView.dart';
import 'package:provider/provider.dart';

class photoBookMarkScreen extends StatefulWidget {
  _PhotoBookMarkScreenState createState() => _PhotoBookMarkScreenState();
}

class _PhotoBookMarkScreenState extends State<photoBookMarkScreen> {
  @override
  void initState(){
    super.initState();
    Provider.of<NasaPhotoBookMarkListModel>(context, listen: false)..loadingBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NasaPhotoBookMarkListModel>(
      builder: (context, model, _) {
        return Stack(
          children: [
            PhotoListView(),
            model.isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: 0,
                    height: 0,
                  )
          ],
        );
      },
    );
  }
}
