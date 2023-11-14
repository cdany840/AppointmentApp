import 'package:flutter/material.dart';

class StyleTextField extends StatelessWidget {
  const StyleTextField({
    super.key,
    required this.controller,
    required this.labelText, 
    required this.icon,
    hideText
  }): obscureText = hideText ?? false;

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Color.fromARGB(255, 51, 51, 51)),
      obscureText: obscureText,
      decoration: InputDecoration(
        icon: Icon(icon),
        iconColor: const Color.fromARGB(255, 51, 51, 51),
        labelText: labelText,
        labelStyle: const TextStyle(color: Color.fromARGB(255, 51, 51, 51)),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 51, 51, 51)
          )
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 51, 51, 51)
          )
        ),
      ),
    );
  }
}

class StyleElevatedButton extends StatelessWidget {
  const StyleElevatedButton({
    super.key, 
    required this.text,
    required this.onPressed,
  });
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 51, 51, 51)),
        foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 245, 245, 245)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        )),
      ),
      child: Text(text)
    );
  }
}