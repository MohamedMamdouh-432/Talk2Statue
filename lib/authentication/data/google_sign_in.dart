import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser =
      await GoogleSignIn(scopes: ['profile', 'email']).signIn();
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  await sharedPrefs.setBool('newToApp?', false);
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
