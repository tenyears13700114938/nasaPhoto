import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/model/nasaPhoto.dart';
import 'package:flutter_nasa_photo/model/nasaPhotoBookMarkListModel.dart';
import 'package:flutter_nasa_photo/view/photoItemView.dart';
import 'package:provider/provider.dart';

class PhotoDetailScreen extends StatelessWidget {
  NasaPhoto nasaPhoto;

  PhotoDetailScreen(this.nasaPhoto){
    log("debug photo detail $nasaPhoto");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).padding.horizontal,
                maxWidth: MediaQuery.of(context).size.width -
                    MediaQuery.of(context).padding.horizontal),
            child: PhotoItemView(nasaPhoto.url, nasaPhoto.title, nasaPhoto.date,
                isShowShadow: true),
          ),
          //Expanded(child: PhotoItemView(nasaPhoto.url, nasaPhoto.title, nasaPhoto.date)),
          Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              nasaPhoto.explanation,
              style: TextStyle(
                fontSize: 20,
                //color: Colors.white
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 8, bottom: 8),
            child: SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                  onPressed: (){
                    NasaPhotoBookMarkListModel model = Provider.of<NasaPhotoBookMarkListModel>(context, listen: false);
                    nasaPhoto.bookMarkType = 1;
                    model.updateBookmark(nasaPhoto);
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.bookmark),
                  label: Text("Add Book mark"),
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Theme.of(context)
                        .floatingActionButtonTheme
                        .foregroundColor),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor),
                  )),
            ),
          )
        ],
      ),
    ));
  }
}
