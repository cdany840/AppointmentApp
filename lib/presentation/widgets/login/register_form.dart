import 'package:appointment_app/config/helpers/login/email_auth.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:appointment_app/presentation/widgets/shared/toast.dart';
import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.emailController,
    required this.passController,
  });

  final TextEditingController emailController;
  final TextEditingController passController;

  @override
  Widget build(BuildContext context) {
    final EmailAuth emailAuth = EmailAuth();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Text('Appointment', 
                style: TextStyle(
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontSize: 24),
                ),
          const SizedBox( height: 16 ),
          StyleTextField(
            controller: emailController,
            labelText: 'Email',
            icon: Icons.email
          ),
          const SizedBox( height: 16 ),
          StyleTextField(
            controller: passController,
            labelText: 'Password',
            icon: Icons.lock,
            hideText: true,
          ),
          const SizedBox( height: 16 ),
          StyleElevatedButton( // ? Presentation/widgets/custom/style_widgets.dart
            text: 'Register',
            onPressed: () {
              final String email = emailController.text;
              final String pass = passController.text;
              emailAuth.createUser(emailUser: email, passUser: pass);
              WidgetToast.show('Verify your email');
              Future.delayed(const Duration(seconds: 1));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}