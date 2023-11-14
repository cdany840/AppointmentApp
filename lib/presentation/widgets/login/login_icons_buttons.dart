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
          onPressed: () {
            
          },
          icon: FontAwesomeIcons.github,
          customColor: color,
        ),
        StyleIcons(
          onPressed: () async {
            // if ( await googleAuth.signInWithGoogle() ) {
            //   Navigator.pushNamed(context, '/home', arguments: {'data': googleAuth.user});
            // }
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