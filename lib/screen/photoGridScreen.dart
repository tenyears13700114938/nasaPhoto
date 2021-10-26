import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/model/nasaPhotoListModel.dart';
import 'package:flutter_nasa_photo/view/photoGridView.dart';
import 'package:provider/provider.dart';

class photoGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<NasaPhotoListModel, bool>(
      selector: (context, model) => model.isLoading,
      builder: (context, isLoading, _) {
        return Stack(
          children: <Widget>[
            PhotoGridView(),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  )
          ],
        );
        if (isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return PhotoGridView();
      },
    );
  }
}
