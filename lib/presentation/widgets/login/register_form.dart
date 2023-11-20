import 'package:appointment_app/config/helpers/login/email_auth.dart';
import 'package:appointment_app/config/helpers/shared/regex.dart';
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
    final formKey = GlobalKey<FormState>();
    bool pressButton = false;

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Text('Appointment', 
                  style: TextStyle(
                    color: Color.fromARGB(255, 51, 51, 51),
                    fontSize: 24),
                  ),
            const SizedBox( height: 16 ),
            StyleTextFormField(
                labelText: 'Email',
                hintText: 'example@mail.com',
                icon: Icons.email,
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (!val!.isValidEmail || val.isEmpty) {
                    return 'Please, enter a valid email.';
                  }
                  return null;
                }
              ),          
              const SizedBox( height: 16 ),
              StyleTextFormField(
                labelText: 'Password',
                hintText: 'T0Rn74\$',
                obscureText: true,
                icon: Icons.lock,
                controller: passController,
                validator: (val) {
                  if (!val!.isValidPassword || val.isEmpty) {
                    return 'Please, enter a valid password or more extends.';
                  }
                  return null;
                }
              ),
            const SizedBox( height: 16 ),
            StyleElevatedButton( // ? Presentation/widgets/custom/style_widgets.dart
              text: 'Register',
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final String email = emailController.text;
                  final String pass = passController.text;
                  emailAuth.createUser(emailUser: email, passUser: pass);
                  WidgetToast.show('Verify your email');
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () async {
                    if ( pressButton ) {
                      await emailAuth.sendEmailVerification();
                      WidgetToast.show('Email Sent');
                    } else {
                      WidgetToast.show('Wait a few minutes');
                      Future.delayed(const Duration(minutes: 5), () => pressButton = !pressButton);
                    }
                  },
                  child: const Text('Forward Email', style: TextStyle(color: Color.fromARGB(255, 245, 245, 245)),),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: const Text('Login', style: TextStyle(color: Color.fromARGB(255, 245, 245, 245)),),
                ),
              ],
            ),            
          ],
        ),
      ),
    );
  }
}