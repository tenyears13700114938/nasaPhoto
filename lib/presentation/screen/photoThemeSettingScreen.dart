import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/data/singingCharacter.dart';
import 'package:flutter_nasa_photo/presentation/state/photoTheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/UserAuthState.dart';

class PhotoThemeSettingScreen extends ConsumerStatefulWidget {
  @override
  _PhotoThemeSettingScreenState createState() =>
      _PhotoThemeSettingScreenState();

  static MaterialPage createPage() {
    return MaterialPage(
        child: PhotoThemeSettingScreen(),
        key: ValueKey('photoThemeSettingScreen'));
  }
}

class _PhotoThemeSettingScreenState
    extends ConsumerState<PhotoThemeSettingScreen> {
  SingingCharacter? _character;

  void initState() {
    super.initState();
    ref.read(photoThemeProvider);
  }

  @override
  Widget build(BuildContext context) {
    SingingCharacter character = ref.watch(photoThemeProvider);
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            title: Text('App Theme choose...'),
          ),
          ListTile(
            title: Text('darkMode'),
            leading: Radio<SingingCharacter>(
              value: SingingCharacter.darkMode,
              groupValue: character,
              onChanged: (SingingCharacter? value) {
                setState(() {
                  _character = value;
                  ref.read(photoThemeProvider.notifier).setScheme(value);
                });
              },
            ),
          ),
          ListTile(
              title: Text('lightMode'),
              leading: Radio<SingingCharacter>(
                value: SingingCharacter.lightMode,
                groupValue: character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                    ref.read(photoThemeProvider.notifier).setScheme(value);
                  });
                },
              )),
          SizedBox(height: 32),
          ElevatedButton(
              onPressed: () {
                ref.read(userAuthStateProvider).logout();
              },
              child: Text("Log Out")),
        ],
      ),
    );
  }
}
