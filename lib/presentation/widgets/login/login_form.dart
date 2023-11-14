import 'package:appointment_app/config/helpers/login/email_auth.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:appointment_app/presentation/widgets/custom/toast.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passController
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
          const Text('Welcome', 
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
            text: 'Login',
            onPressed: () async {
              if(emailController.text.isEmpty && passController.text.isEmpty){
                WidgetToast.show('Empty User and Pass');          
              } else if (passController.text.isEmpty) {
                  WidgetToast.show('Empty Pass');
                } else if (emailController.text.isEmpty) {
                    WidgetToast.show('Empty User');
                  } else {
                      if ( await emailAuth.validateUser(emailUser: emailController.text, passUser: passController.text) ) {
                        Navigator.pushNamed(context, '/register'); 
                      } else {
                        WidgetToast.show('Credentials Invalidate');
                      }              
              }
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot');
                },
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