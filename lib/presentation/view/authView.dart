import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  final void Function(String email, String password, String name, bool isLogin)
      loginHandler;

  AuthView({required this.loginHandler});

  @override
  State<StatefulWidget> createState() {
    return AuthState();
  }
}

class AuthState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = "";
  String _userName = "";
  String _userPassword = "";
  bool _isLogin = true;

  void _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      _formKey.currentState?.save();
      widget.loginHandler(_userEmail, _userPassword, _userName, _isLogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: ValueKey("email"),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email Address"),
                  validator: (value) {
                    if (value == null || !value.contains("@")) {
                      return "please input str which contains @";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userEmail = value ?? "";
                  },
                ),
                if (!_isLogin)
                  TextFormField(
                    key: ValueKey("name"),
                    decoration: InputDecoration(labelText: "User Name"),
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return "please input str which at least contains five characters";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userName = value ?? "";
                    },
                  ),
                TextFormField(
                  key: ValueKey("password"),
                  decoration: InputDecoration(labelText: "Password"),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 7) {
                      return "please input str which at least contains seven characters";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userPassword = value ?? "";
                  },
                ),
                IntrinsicWidth(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 16),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: ElevatedButton(
                          onPressed: _trySubmit,
                          child: Text(_isLogin ? "Login" : "Sign up")),
                    ),
                    SizedBox(height: 8),
                    OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? "Create a Account"
                            : "already have a account"))
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
