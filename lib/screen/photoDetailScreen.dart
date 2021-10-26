import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/model/nasaPhoto.dart';
import 'package:flutter_nasa_photo/view/photoItemView.dart';

class PhotoDetailScreen extends StatelessWidget {
  final NasaPhoto nasaPhoto;

  PhotoDetailScreen(this.nasaPhoto);

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
                  onPressed: null,
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
