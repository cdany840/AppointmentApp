import 'package:appointment_app/config/helpers/login/auth_status.dart';
import 'package:appointment_app/config/helpers/shared/regex.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:appointment_app/presentation/widgets/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final _formKey = GlobalKey<FormState>();
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
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 191, 211, 244)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox( height: 16 ),
                const Text('Reset Password', 
                      style: TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 24),
                      ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  labelText: 'Email',
                  hintText: 'example@mail.com',
                  icon: Icons.email,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (!val!.isValidEmail || val.isEmpty) {
                      return 'Please, enter a valid email.';
                    }
                    return null;
                  }
                ),
                const SizedBox( height: 16 ),
                StyleElevatedButton(
                  text: 'Reset',
                  onPressed: () async {
                    try {
                      if (_formKey.currentState!.validate()) {
                        resetPassword(email: _emailController.text);
                      }
                      WidgetToast.show('Email Sent to ${_emailController.text}');
                      Navigator.pop(context);
                    } catch (e) {
                      WidgetToast.show('The email is not registered');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}