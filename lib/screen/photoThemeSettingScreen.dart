import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/model/photoTheme.dart';
import 'package:flutter_nasa_photo/nasaPhotoTheme.dart';
import 'package:provider/provider.dart';

class PhotoThemeSettingScreen extends StatefulWidget {
  @override
  _PhotoThemeSettingScreenState createState() =>
      _PhotoThemeSettingScreenState();
}

enum SingingCharacter { darkMode, lightMode }

class _PhotoThemeSettingScreenState extends State<PhotoThemeSettingScreen> {
  SingingCharacter? _character;

  void initState() {
    super.initState();
    Provider.of<PhotoTheme>(context, listen: false)..getScheme();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotoTheme>(builder: (context, photoTheme, _) {
      _character = photoTheme.photoScheme;
      log("debug $_character");
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(title: Text('App Theme choose...')),
          ListTile(
            title: Text('darkMode'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.darkMode,
              groupValue: _character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                  Provider.of<PhotoTheme>(context, listen: false)
                      .setScheme(value);
                });
              },
            ),
          ),
          ListTile(
              title: Text('lightMode'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.lightMode,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                    Provider.of<PhotoTheme>(context, listen: false)
                        .setScheme(value);
                  });
                },
              )),
        ],
      );
    });
  }
}
