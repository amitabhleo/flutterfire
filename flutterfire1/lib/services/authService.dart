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

  //signin web
  FirebaseAuth auth = FirebaseAuth.instance;

  Future signInPhone(String phone) async {
// Wait for the user to complete the reCAPTCHA & for an SMS code to be sent.
    ConfirmationResult confirmationResult =
        await auth.signInWithPhoneNumber(phone);

    UserCredential userCredential = await confirmationResult.confirm('123456');

    print('User Details:  $userCredential.user!.uid');
  }
}
//signin mobile OTP android not working

// Future signInMobile() async {
//   await _auth.verifyPhoneNumber(
//       phoneNumber: '+91 8383948897',
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         // ANDROID ONLY!
//
//         // Sign the user in (or link) with the auto-generated credential
//         await _auth.signInWithCredential(credential);
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         if (e.code == 'invalid-phone-number') {
//           print('The provided phone number is not valid.');
//         }
//
//         // Handle other errors
//       },
//      // codeSent: (String verificationId, int resendToken),
//      //  codeSent: (String verificationId, int resendToken) async {
//      //    // Update the UI - wait for the user to enter the SMS code
//      //    String smsCode = '4585';
//      //
//      //    // Create a PhoneAuthCredential with the code
//      //    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
//      //
//      //    // Sign the user in (or link) with the credential
//      //    await auth.signInWithCredential(credential);
//      //  },
//
//
//       //codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
//   timeout: const Duration(seconds: 60),
//   codeAutoRetrievalTimeout: (String verificationId) {
//   // Auto-resolution timed out...
//   },
// }
