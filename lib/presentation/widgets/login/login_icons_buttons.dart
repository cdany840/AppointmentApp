import 'package:appointment_app/config/helpers/login/auth_github.dart';
import 'package:appointment_app/config/helpers/login/auth_google.dart';
import 'package:appointment_app/infrastructure/shared_preferences.dart';
import 'package:appointment_app/presentation/widgets/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginIconsButtons extends StatelessWidget {
  const LoginIconsButtons({super.key, this.color});
  final Color? color;

  @override
  Widget build(BuildContext context) {
    // GoogleAuth googleAuth = GoogleAuth();

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
              UserCredential userCredential = await auServiceGH().signInWithGitHub();
              if(context.mounted){
                Preferences.prefsSession.setBool('session', true);
                Navigator.pushNamed(context, '/home', arguments: {'data': userCredential.user!.displayName});
              }
            }catch  (e){
              WidgetToast.show('Error login con GitHub');
              print("Error login con GitHub: " + e.toString());
            }
          },
          icon: FontAwesomeIcons.github,
          customColor: color,
        ),
        StyleIcons(
          onPressed: () async {
            var userCredential = await auServiceG().signInWithGoogle();
            if(userCredential != null){
              Preferences.prefsSession.setBool('session', true);
              Navigator.pushNamed(context, '/home', arguments: {'data': userCredential.user.displayName});
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