import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAuthState {
  UserAuthState._();
}

class UserAuthSuccess extends UserAuthState {
  User? user;

  UserAuthSuccess(this.user) : super._();
}

class UserAuthError extends UserAuthState {
  Exception? exception;

  UserAuthError(this.exception) : super._();
}

final userAuthStateProvider = ChangeNotifierProvider<UserAuthNotifier>((ref) {
  return UserAuthNotifier();
});

class UserAuthNotifier extends ChangeNotifier {
  UserAuthState? user;

  UserAuthNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      notifyListeners();
    });
  }

  void login(String email, String password, String userName) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("firebase check success.....");
      user = UserAuthSuccess(credential.user);
    } on Exception catch (e) {
      user = UserAuthError(e);
    }
    notifyListeners();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  void signIn(String email, String password, String userName) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      user = UserAuthSuccess(credential.user);
    } on Exception catch (e) {
      user = UserAuthError(e);
    }
    notifyListeners();
  }
}
