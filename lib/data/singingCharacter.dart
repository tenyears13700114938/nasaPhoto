import 'package:flutter/material.dart';

import '../nasaPhotoTheme.dart';

enum SingingCharacter { darkMode, lightMode }

extension SingingCharacterExtension on SingingCharacter {
  ThemeData get photoThemeData {
    ThemeData result;
    switch (this) {
      case SingingCharacter.darkMode:
        result = NasaPhotoTheme.dark();
        break;
      case SingingCharacter.lightMode:
        result = NasaPhotoTheme.light();
        break;
      default:
        result = NasaPhotoTheme.dark();
        break;
    }
    return result;
  }
}
