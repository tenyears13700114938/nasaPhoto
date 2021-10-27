import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/model/nasaPhotoListModel.dart';
import 'package:flutter_nasa_photo/repository/dataBaseRepository.dart';
import 'package:flutter_nasa_photo/repository/nasaRepository.dart';
import 'package:flutter_nasa_photo/repository/webRepository.dart';
import 'package:flutter_nasa_photo/screen/photoBookMarkScreen.dart';
import 'package:flutter_nasa_photo/screen/photoGridScreen.dart';
import 'package:provider/provider.dart';
import 'model/nasaPhotoBookMarkListModel.dart';
import 'nasaPhotoTheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) {
      return NasaPhotoListModel(MyRepository())..loadPhotos();
    }),
    ChangeNotifierProvider(create: (context) {
      return NasaPhotoBookMarkListModel(MyRepository())..loadingBookmark();
    })
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final theme = NasaPhotoTheme.dark();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: MyHomePage(
          key: ValueKey("todo"),
          title:
              'Flutter Nasa Photo Page'), //NasaWebView("https://www.youtube.com/embed/aokGqxVdpz0?rel=0"),/
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required Key key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
                icon: Icon(Icons.list,
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor)),
            Tab(
                icon: Icon(Icons.bookmark,
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor))
          ],
        ),
        body: TabBarView(
          children: [photoGridScreen(), photoBookMarkScreen()],
        ),
      ),
    );
    ;
  }
}
