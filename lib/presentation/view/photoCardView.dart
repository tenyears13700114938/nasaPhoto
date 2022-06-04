import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/core/usecases/utils/photoImageProvider.dart';
import 'package:flutter_nasa_photo/domain/entites/nasaPhoto.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoRouteState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../route/nasaPhotoRoute.dart';

class PhotoCardView extends ConsumerWidget {
  final NasaPhoto photo;

  PhotoCardView(this.photo);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.all(4),
        child: GestureDetector(
          onTap: () {
            ref
                .read<NasaPhotoRouteState>(nasaPhotoRouteStateProvider)
                .push(NasaPhotoDetail(photo));
          },
          child: Card(
            child: ListTile(
              leading: SizedBox(
                width: 60,
                height: 60,
                child: FittedBox(fit: BoxFit.fill, child: _getItemView()),
              ),
              title: Text(photo.title),
              subtitle: Text(
                photo.explanation,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ));
  }

  Widget _getItemView() {
    if (photo.url.endsWith('jpg')) {
      return FutureBuilder<ImageProvider>(
        future: PhotoImageProvider(photo.url, photo.date).getProvider(),
        builder: (BuildContext context, AsyncSnapshot<ImageProvider> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            // ignore: missing_return
            return Image(image: snapshot.data as ImageProvider<Object>);
          }
          return Image.memory(kTransparentImage);
        },
      );
    } else {
      return Icon(Icons.photo);
    }
  }
}
