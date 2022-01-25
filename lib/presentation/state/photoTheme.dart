import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_nasa_photo/data/singingCharacter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final photoThemeProvider =
    StateNotifierProvider<PhotoThemeNotifier, SingingCharacter>((ref) {
  return PhotoThemeNotifier();
});

class PhotoThemeNotifier extends StateNotifier<SingingCharacter> {
  SingingCharacter? _photoScheme = SingingCharacter.darkMode;

  PhotoThemeNotifier() : super(SingingCharacter.darkMode) {
    _getScheme();
  }

  void _getScheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("photoTheme")) {
      String modeValue = prefs.getString("photoTheme") ?? "darkMode";
      state = EnumToString.fromString(SingingCharacter.values, modeValue) ??
          SingingCharacter.darkMode;
    }
  }

  void setScheme(SingingCharacter? theme) async {
    if (theme != null) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("photoTheme", EnumToString.convertToString(theme));
      state = theme;
    }
  }
}
