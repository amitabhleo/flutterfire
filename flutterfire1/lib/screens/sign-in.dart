import 'package:flutter/material.dart';
import 'package:flutterfire1/services/authService.dart';

class SignIn extends StatelessWidget {
  AuthService _authSer = AuthService();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign in anonymous'),
        ),
        body: TextButton(
          onPressed: () {
            _authSer.signInAnony();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'SignIn anonymous',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ),
      ),
    );
  }
}
