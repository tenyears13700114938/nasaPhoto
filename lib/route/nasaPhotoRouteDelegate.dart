import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/presentation/screen/Home.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoRouteState.dart';
import 'package:flutter_nasa_photo/route/nasaPhotoRoute.dart';

import '../presentation/screen/AuthScreen.dart';
import '../presentation/screen/photoDetailScreen.dart';

class NasaPhotoRouteDelegate extends RouterDelegate<NasaPhotoRoute>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<NasaPhotoRoute> {
  final GlobalKey<NavigatorState> _navigatorKey;
  final NasaPhotoRouteState routeState;

  NasaPhotoRouteDelegate(this.routeState)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    routeState.addListener(notifyListeners);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: [
        if (FirebaseAuth.instance.currentUser == null) AuthScreen.createPage(),
        if (FirebaseAuth.instance.currentUser != null) HomeScreen.createPage(),
        ...routeState.routeList.where((element) => !(element is Home)).map((e) {
          if (e is NasaPhotoDetail) {
            return PhotoDetailScreen.createPage(e.detailPhoto);
          }
          return MaterialPage(
              child: Scaffold(
            body: Center(
              child: Text("Not found ....."),
            ),
          ));
        })
      ],
      onPopPage: (route, info) {
        if (!route.didPop(info)) {
          return false;
        }
        //Todo UseCase check
        routeState.routeList.removeLast();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(NasaPhotoRoute configuration) async {
    if (configuration is NasaPhotoGrid ||
        configuration is NasaPhotoBookmark ||
        configuration is NasaPhotoTheme) {
      routeState.routeList.clear();
      routeState.push(configuration);
    } else {
      routeState.routeList.add(configuration);
    }
  }
}
