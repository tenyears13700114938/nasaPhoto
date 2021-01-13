
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
              maxHeight:  MediaQuery.of(context).size.width - MediaQuery.of(context).padding.horizontal,
              maxWidth:  MediaQuery.of(context).size.width - MediaQuery.of(context).padding.horizontal
              ),
            child: PhotoItemView(nasaPhoto.url, nasaPhoto.title, nasaPhoto.date),
          ),
          //Expanded(child: PhotoItemView(nasaPhoto.url, nasaPhoto.title, nasaPhoto.date)),
          Text(
            nasaPhoto.explanation,
            style: TextStyle(
              fontSize: 20,
              //color: Colors.white
            ),
          )
        ],
      ),
    ));
  }
}