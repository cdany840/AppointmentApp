import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

// * Form Style ----------------------------------

InputDecoration styleInputForm(String label, String? hint, IconData? icon) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    icon: Icon(icon),
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
  );
}

class StyleTextFormField extends StatelessWidget {
  const StyleTextFormField({
    super.key,
    this.hintText,
    required this.labelText,
    required this.controller,
    this.icon,
    this.obscureText,
    this.readOnly,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.maxLines
  });

  final String? hintText;
  final String labelText;
  final int? maxLines;
  final bool? obscureText;
  final bool? readOnly;
  final IconData? icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: styleInputForm(labelText, hintText, icon)
    );
  }
}

class StyleDropdownButtonFormField extends StatelessWidget {
  const StyleDropdownButtonFormField({
    super.key,
    required this.items,
    required this.labelText,
    required this.hintText,
    required this.onChange,
    this.icon,
    this.validator,
    this.value,
  });

  final String labelText;
  final String hintText;
  final String? value;
  final IconData? icon;
  final List<String> items;
  final String? Function(String?)? validator;
  final ValueChanged<String?> onChange;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: value,
      isExpanded: true,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: styleInputForm(labelText, hintText, icon),
      items: items.map((String items) { 
        return DropdownMenuItem( 
          value: items, 
          child: Center( child: Text(items) ),
        ); 
      }).toList(),
      onChanged: onChange,
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
      // style: ButtonStyle(
      //   backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 51, 51, 51)),
      //   foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 245, 245, 245)),
      //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(6),
      //   )),
      // ),
      child: Text(text)
    );
  }
}

class ContainerImage extends StatelessWidget {
  const ContainerImage({
    super.key,
    required this.imageUrl,
  });
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.height;
    return Container(
      margin: const EdgeInsets.only( top: 20),
      height: screen * 0.2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          placeholder: (context, url) => const CircularProgressIndicator(),
          imageUrl: imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}