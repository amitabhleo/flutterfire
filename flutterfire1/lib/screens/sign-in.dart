import 'package:flutter/material.dart';
import 'package:flutterfire1/services/authService.dart';

class SignIn extends StatelessWidget {
  AuthService _authSer = AuthService();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign in '),
        ),
        body: Column(
          children: [
            TextButton(
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
            SizedBox(
              height: 20.0,
            ),
            TextButton(
              onPressed: () {
                _authSer.signInPhone("+44 7444 555666");
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'SignIn with +44 7444 555666',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
