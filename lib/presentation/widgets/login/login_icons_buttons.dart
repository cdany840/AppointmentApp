import 'package:appointment_app/infrastructure/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:appointment_app/config/helpers/login/auth_github.dart';
import 'package:appointment_app/config/helpers/login/auth_google.dart';
import 'package:appointment_app/presentation/widgets/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginIconsButtons extends StatelessWidget {
  const LoginIconsButtons({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        StyleIcons(
          onPressed: () {
            
          },
          icon: FontAwesomeIcons.facebook,
          customColor: color,
        ),
        StyleIcons(
          onPressed: () async {
            try{
              UserCredential userCredential = await AuServiceGH().signInWithGitHub();
              if(context.mounted){
                userCredential.toString();
                Preferences.prefsLogin.setString('login', 'Github'); // ? Debería guardar tipo sessión.
                Preferences.prefsSession.setBool('session', true);
                Navigator.pushNamed(context, '/home');
              }
            }catch  (e){
              WidgetToast.show('Error login con GitHub');
            }
          },
          icon: FontAwesomeIcons.github,
          customColor: color,
        ),
        StyleIcons(
           onPressed: () async {
            var userCredential = await AuServiceG().signInWithGoogle();
            if(userCredential != null){
              Preferences.prefsLogin.setString('login', 'Google'); // ? Debería guardar tipo sessión.
              Preferences.prefsSession.setBool('session', true);
              Navigator.pushNamed(context, '/home');
            }else{
              WidgetToast.show('Error login con Google');
            }
          },
          icon: FontAwesomeIcons.google,
          customColor: color,
        ),
      ],
    );
  }
}

class StyleIcons extends StatelessWidget {
  const StyleIcons({
    super.key,
    required this.onPressed,
    required this.icon,
    customColor
  }): color = customColor ?? const Color.fromARGB(255, 153, 0, 105);

  final VoidCallback onPressed;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 40,
      color: color,
      icon: FaIcon(icon)
    );
  }
}