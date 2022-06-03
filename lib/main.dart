import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/data/singingCharacter.dart';
import 'package:flutter_nasa_photo/presentation/state/nasaPhotoRouteState.dart';
import 'package:flutter_nasa_photo/presentation/state/photoTheme.dart';
import 'package:flutter_nasa_photo/route/nasaPhotoRouteDelegate.dart';
import 'package:flutter_nasa_photo/route/nasaPhotoRouteInformationParser.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  // This widget is the root of your application.
  //final theme = NasaPhotoTheme.dark();
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late NasaPhotoRouteDelegate routeDelegate;
  NasaPhotoRouteInformationParser parser = NasaPhotoRouteInformationParser();

  @override
  void initState() {
    super.initState();
    routeDelegate =
        NasaPhotoRouteDelegate(ref.read(nasaPhotoRouteStateProvider));
  }

  @override
  Widget build(BuildContext context) {
    SingingCharacter character = ref.watch(photoThemeProvider);
    return MaterialApp.router(
      title: 'Nasa Photo...',
      theme: character.photoThemeData,
      routerDelegate: routeDelegate,
      routeInformationParser: parser,
    );
  }
}
