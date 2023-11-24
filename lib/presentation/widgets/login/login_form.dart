import 'package:appointment_app/config/helpers/shared/services_firebase.dart';
import 'package:appointment_app/config/helpers/login/email_auth.dart';
import 'package:appointment_app/config/helpers/shared/regex.dart';
import 'package:appointment_app/infrastructure/shared_preferences.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:appointment_app/presentation/widgets/profile/profile_form.dart';
import 'package:appointment_app/presentation/widgets/shared/toast.dart';
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
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            const Text('Welcome', 
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
              icon: Icons.lock,
              obscureText: true,
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
              text: 'Login',
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if ( await emailAuth.validateUser(emailUser: emailController.text, passUser: passController.text) ) {
                    final checkProfile = ServicesFirebase(collection: 'profile');
                    Preferences.prefsSession.setBool('session', true);
                    if ( await checkProfile.getOneRecordProfile(ServicesFirebase.uid) == null ) {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileForm()));
                    } else {
                      Navigator.pushNamed(context, '/home');
                    }
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
      ),
    );
  }
}