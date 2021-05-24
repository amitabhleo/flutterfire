import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//sign in anonymously

  Future signInAnony() async {
    try {
      UserCredential _result = await FirebaseAuth.instance.signInAnonymously();
      print(_result.user!.uid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

//signin phone
