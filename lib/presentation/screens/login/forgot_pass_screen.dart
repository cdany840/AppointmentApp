import 'package:appointment_app/config/helpers/login/auth_status.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _auth = FirebaseAuth.instance;
  AuthStatus _status = AuthStatus.unknown;
  final TextEditingController _emailController = TextEditingController();

  Future<AuthStatus> resetPassword({required String email}) async {
  await _auth
      .sendPasswordResetEmail(email: email)
      .then((value) => _status = AuthStatus.successful)
      .catchError((e) => _status = AuthExceptionHandler.handleAuthException(e));
  return _status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Text('Reset Password', 
                style: TextStyle(
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: 24),
                ),
          const SizedBox( height: 16 ),
          StyleTextField(
            controller: _emailController,
            labelText: 'Email',
            icon: Icons.email
          ),
          const SizedBox( height: 16 ),
          StyleElevatedButton(
            text: 'Reset',
            onPressed: () async {
              resetPassword(email: _emailController.text);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Forgot Password', style: TextStyle(color: Color.fromARGB(255, 245, 245, 245)),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Register', style: TextStyle(color: Color.fromARGB(255, 245, 245, 245)),),
              ),
            ],
          )
        ],
      ),
    );
  }
}