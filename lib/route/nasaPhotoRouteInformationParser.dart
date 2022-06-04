import 'package:flutter/cupertino.dart';
import 'package:flutter_nasa_photo/route/nasaPhotoRoute.dart';

class NasaPhotoRouteInformationParser
    extends RouteInformationParser<NasaPhotoRoute> {
  @override
  Future<NasaPhotoRoute> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location ?? "");
    if (uri.pathSegments.length == 0) {
      return Home();
    }
    return NasaPhotoUnknown();
  }
}
