import 'package:firebase_auth/firebase_auth.dart';

class auServiceGH{

  Future<UserCredential> signInWithGitHub() async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(githubAuthProvider);
  }

}