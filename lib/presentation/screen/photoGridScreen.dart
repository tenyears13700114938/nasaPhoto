import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoListModel.dart';
import 'package:flutter_nasa_photo/presentation/view/photoGridView.dart';
import 'package:provider/provider.dart';

class photoGridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NasaPhotoListModel>(
      builder: (context, model, _) {
        return Stack(
          children: <Widget>[
            PhotoGridView(),
            model.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SizedBox(
                    width: 0,
                    height: 0,
                  )
          ],
        );
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return PhotoGridView();
      },
    );
  }
}
