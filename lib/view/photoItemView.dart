
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/repository/photoImageProvider.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoItemView extends StatelessWidget {
  final String imageUrl;
  final String imageTitle;
  final String date;

  PhotoItemView(this.imageUrl, this.imageTitle, this.date);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black45,
        title: _GridTitleText(imageTitle)
      ),
      child:
          FutureBuilder<ImageProvider>(
            future: PhotoImageProvider(imageUrl, date).getProvider(),
            builder: (BuildContext context, AsyncSnapshot<ImageProvider> snapshot){
              if(snapshot.hasData){
                // ignore: missing_return
                return Image(image: snapshot.data);
              }
              return Image.memory(kTransparentImage);
            },
          ),
      );
  }
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
     // fit: BoxFit.contain,
      alignment: Alignment.topLeft,
      child: Text(text,
      maxLines: 2,
      ),
    );
  }
}