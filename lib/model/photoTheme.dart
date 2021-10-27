import 'package:enum_to_string/enum_to_string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nasa_photo/nasaPhotoTheme.dart';
import 'package:flutter_nasa_photo/screen/photoThemeSettingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhotoTheme extends ChangeNotifier implements Equatable {
  SingingCharacter? _photoScheme = SingingCharacter.darkMode;

  SingingCharacter? get photoScheme => _photoScheme;

  ThemeData get photoThemeData {
    ThemeData result;
    switch (_photoScheme) {
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

  @override
  List<Object?> get props => [_photoScheme];

  @override
  bool? get stringify => false;

  void getScheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("photoTheme")) {
      String modeValue = prefs.getString("photoTheme") ?? "darkMode";
      _photoScheme =
          EnumToString.fromString(SingingCharacter.values, modeValue);
    } else {
      _photoScheme = SingingCharacter.darkMode;
    }
    notifyListeners();
  }

  void setScheme(SingingCharacter? theme) async {
    if (theme != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("photoTheme", EnumToString.convertToString(theme));
      _photoScheme = theme;
      notifyListeners();
    }
  }
}
