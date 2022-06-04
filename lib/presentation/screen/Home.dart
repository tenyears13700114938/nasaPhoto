import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_nasa_photo/presentation/screen/photoBookMarkScreen.dart';
import 'package:flutter_nasa_photo/presentation/screen/photoGridScreen.dart';
import 'package:flutter_nasa_photo/presentation/screen/photoThemeSettingScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeState();
  }

  static MaterialPage createPage() {
    return MaterialPage(child: HomeScreen(), key: ValueKey('home'));
  }
}

class HomeState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                        .backgroundColor)),
            Tab(
                icon: Icon(Icons.settings,
                    color: Theme.of(context)
                        .floatingActionButtonTheme
                        .backgroundColor))
          ],
        ),
        body: TabBarView(
          children: [
            PhotoGridScreen(),
            PhotoBookMarkScreen(),
            PhotoThemeSettingScreen()
          ],
        ),
      ),
    );
  }
}
