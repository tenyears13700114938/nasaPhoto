import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/authView.dart';

class AuthScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AuthState();

  static MaterialPage createPage() =>
      MaterialPage(key: ValueKey("AuthScreen"), child: AuthScreen());
}

class AuthState extends ConsumerState<AuthScreen> {
  void _auth(String email, String password, String userName, bool isLogin) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthView(loginHandler: _auth),
    );
  }
}
