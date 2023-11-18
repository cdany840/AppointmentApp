import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser({ required String emailUser, required String passUser }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(email: emailUser, password: passUser);
      credential.user!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;

    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  Future<bool> validateUser({ required String emailUser, required String passUser }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(email: emailUser, password: passUser);
      if ( credential.user!.emailVerified ) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

}