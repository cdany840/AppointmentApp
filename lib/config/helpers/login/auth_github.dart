import 'package:firebase_auth/firebase_auth.dart';

class AuServiceGH{
  final GithubAuthProvider _githubAuthProvider = GithubAuthProvider();

  Future<UserCredential> signInWithGitHub() async {
    return await FirebaseAuth.instance.signInWithProvider(_githubAuthProvider);
  }
}