
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/repository/photoImageProvider.dart';
import 'package:flutter_nasa_photo/view/nasaWebView.dart';
import 'package:transparent_image/transparent_image.dart';

class PhotoItemView extends StatelessWidget {
  final String imageUrl;
  final String imageTitle;
  final String date;
  final bool isShowShadow;

  PhotoItemView(this.imageUrl, this.imageTitle, this.date, {this.isShowShadow = false});

  @override
  Widget build(BuildContext context) {
    print("imageUrl $imageUrl");
    return
      Padding(padding: EdgeInsets.all(2),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(const Radius.circular(8)),
            border: Border.all(width: 4, color: Colors.white),
            boxShadow: isShowShadow ? [
              BoxShadow(
                color: Colors.black38.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ] : [],
          ),
          child: GridTile(
            footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: _GridTitleText(imageTitle)
            ),
            child: FittedBox(
              fit: BoxFit.fill,
              child: getItemView(),
            ),
          ),
        )
      );
  }

  Widget getItemView() {
    if(imageUrl.endsWith('jpg')){
      return FutureBuilder<ImageProvider>(
        future: PhotoImageProvider(imageUrl, date).getProvider(),
        builder: (BuildContext context, AsyncSnapshot<ImageProvider> snapshot){
          if(snapshot.hasData && snapshot.data != null){
            // ignore: missing_return
            return Image(image: snapshot.data as ImageProvider<Object>);
          }
          return Image.memory(kTransparentImage);
        },
      );
    } else {
      return NasaWebView(imageUrl);
    }
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