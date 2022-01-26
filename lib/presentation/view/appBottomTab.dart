import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/presentation/screen/photoBookMarkScreen.dart';
import 'package:flutter_nasa_photo/presentation/screen/photoGridScreen.dart';
import 'package:flutter_nasa_photo/presentation/screen/photoThemeSettingScreen.dart';

class AppBottomTab extends StatelessWidget {
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
