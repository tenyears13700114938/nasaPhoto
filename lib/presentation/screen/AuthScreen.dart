import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_nasa_photo/presentation/state/UserAuthState.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/nasaPhotoRouteState.dart';
import '../view/authView.dart';

class AuthScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AuthState();

  static MaterialPage createPage() =>
      MaterialPage(key: ValueKey("AuthScreen"), child: AuthScreen());
}

class AuthState extends ConsumerState<AuthScreen> {
  void _auth(String email, String password, String userName, bool isLogin) {
    if (isLogin) {
      ref.read(userAuthStateProvider).login(email, password, userName);
    } else {
      ref.read(userAuthStateProvider).signIn(email, password, userName);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<UserAuthNotifier>(userAuthStateProvider, (previous, next) {
      if (next.user is UserAuthSuccess) {
        ref.read(nasaPhotoRouteStateProvider).loginSuccess();
      } else if (next.user is UserAuthError) {
        final error = (next.user as UserAuthError).exception;
        final snackBar = SnackBar(content: Text(error?.toString() ?? "error"));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    return Scaffold(
      body: AuthView(loginHandler: _auth),
    );
  }
}
