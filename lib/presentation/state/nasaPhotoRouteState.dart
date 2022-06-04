import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/route/nasaPhotoRoute.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nasaPhotoRouteStateProvider = Provider((ref) {
  return NasaPhotoRouteState();
});

class NasaPhotoRouteState extends ChangeNotifier {
  List<NasaPhotoRoute> routeList = List.of([]);

  NasaPhotoRoute? get currentPage =>
      routeList.length > 0 ? routeList.last : null;

  void push(NasaPhotoRoute route) {
    routeList.add(route);
    notifyListeners();
  }

  void pop() {
    routeList.removeLast();
    notifyListeners();
  }

  void loginSuccess() {
    routeList.clear();
    notifyListeners();
  }
}
