import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuServiceG{
  final GoogleSignIn _google = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async{
    final GoogleSignInAccount? gUser = await _google.signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOutWithGoogle() async {
    await FirebaseAuth.instance.signOut();
    await _google.signOut();
  }

}