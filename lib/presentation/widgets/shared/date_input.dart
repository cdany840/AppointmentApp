import 'package:appointment_app/presentation/providers/form/provider_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

  InputDecoration setInputDecoration(String label, String hint, IconData icon) {
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

class DateInputField extends StatelessWidget {
  DateInputField({
    super.key, 
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.onDateSelected,
    this.validator,
    dateDefault
  }): firstDate = dateDefault ?? DateTime(DateTime.now().year - 33, 1, 1);

  final TextEditingController controller;
  final String label;
  final String hint;
  final Function(DateTime)? onDateSelected;
  final DateTime? firstDate;
  final String? Function(String?)? validator;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: setInputDecoration(label, hint, icon),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context, 
          initialDate: firstDate!,
          firstDate: firstDate!,
          lastDate: DateTime(DateTime.now().year - 18, 12, 31),
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          controller.text = formattedDate;
          if (onDateSelected != null) {
            onDateSelected!(pickedDate);
          }
        }
      },
    );
  }
}

class TimeInput extends StatelessWidget {
  const TimeInput({
    super.key, 
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final String? Function(String?)? validator;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final inputTime = context.watch<ProviderInputTime>();

    Future<void> selectTime(BuildContext context) async {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: inputTime.selectedTime,
      );
      if (picked != null && picked != inputTime.selectedTime) {
        inputTime.selectedTime = picked;
      }
    }

    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: true,
      onTap: () {
        selectTime(context);
        controller.text = inputTime.selectedTime.format(context);
      },
      decoration: setInputDecoration(label, hint, icon)
    );
  }
}