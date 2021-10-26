import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_nasa_photo/model/nasaPhotoListModel.dart';
import 'package:flutter_nasa_photo/repository/dataBaseRepository.dart';
import 'package:flutter_nasa_photo/repository/nasaRepository.dart';
import 'package:flutter_nasa_photo/repository/webRepository.dart';
import 'package:flutter_nasa_photo/view/photoGridView.dart';
import 'package:provider/provider.dart';
import 'nasaPhotoTheme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
  runApp(
      ChangeNotifierProvider(
        create: (context) {
          final repository = MyRepository(DatabaseRepository(), WebRepository());
          repository.init();
          return NasaPhotoListModel(repository)..loadPhotos();
        },
        child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final theme = NasaPhotoTheme.dark();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: MyHomePage(key: ValueKey("todo"), title: 'Flutter Nasa Photo Page'), //NasaWebView("https://www.youtube.com/embed/aokGqxVdpz0?rel=0"),/
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
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body:  Selector<NasaPhotoListModel, bool>(
        selector: (context, model) => model.isLoading,
        builder: (context, isLoading, _){
          return Stack(
            children: <Widget>[
              PhotoGridView(),
              isLoading ? Center(
                child: CircularProgressIndicator(),
              ) : SizedBox(width: 0, height: 0,)
            ],
          );
          if(isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return PhotoGridView();
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

