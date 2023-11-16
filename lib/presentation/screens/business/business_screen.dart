import 'package:appointment_app/presentation/providers/form/form_provider.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/config/helpers/shared/regex.dart';
import 'package:provider/provider.dart';

class BusinessScreen extends StatefulWidget {
  const BusinessScreen({super.key});

  @override
  State<BusinessScreen> createState() => _BusinessScreenState();
}

class _BusinessScreenState extends State<BusinessScreen> {
  final _formKey = GlobalKey<FormState>();
  String? dropdownValue;
  final items = [ 'Aesthetics', 'Office', 'Mechanic', 'Restaurant', 'Dentist' ];
  TextEditingController contName = TextEditingController();
  TextEditingController contSurnames = TextEditingController();
  TextEditingController contAddress = TextEditingController();
  TextEditingController contEmail = TextEditingController();
  TextEditingController contApartment = TextEditingController();
  TextEditingController contPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dropDownProvider = context.watch<ProviderDropdown>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  hintText: 'Mary\'s Groceries',
                  labelText: 'Business Name',
                  controller: contName,
                  validator: (val) {
                    if (!val!.isValidName || val.isEmpty) {
                      return 'Please, enter a valid business name.';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  hintText: 'OXXO',
                  labelText: 'Brand Name',
                  controller: contSurnames,
                  validator: (val) {
                    if (!val!.isValidName || val.isEmpty) {
                      return 'Please, enter a valid brand name.';
                    }
                    return null;
                  }                  
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  hintText: 'Presa Falcón 100',
                  labelText: 'Business Address',
                  controller: contAddress,
                  validator: (val) {
                    if (!val!.isValidAddress || val.isEmpty) {
                      return 'Please, enter a valid business address.';
                    }
                    return null;
                  }
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  hintText: '(Optional)',
                  labelText: 'Apartment / Office',
                  controller: contApartment,
                  validator: (val) {
                    if (!val!.isValidApartment) {
                      return 'Please, enter a valid apartment / office.';
                    }
                    return null;
                  }
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  keyboardType: TextInputType.phone,
                  hintText: '0000 - 000 - 000 - 000',
                  labelText: 'Business Phone Number',
                  controller: contPhone,
                  validator: (val) {
                    if (!val!.isValidPhone || val.isEmpty) {
                      return 'Please, enter a valid phone number.';
                    }
                    return null;
                  }
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'example@email.com',
                  labelText: 'Business email',
                  controller: contEmail,
                  validator: (val) {
                    if (!val!.isValidEmail || val.isEmpty) {
                      return 'Please, enter a valid email.';
                    }
                    return null;
                  }
                ),
                const SizedBox( height: 16 ),
                StyleDropdownButtonFormField(
                  hintText: 'Restaurant',
                  labelText: 'Business Type',
                  value: dropdownValue,
                  items: items,                  
                  validator: (val) {
                    if (val == null) {
                      return 'Please, choose a business type.';
                    }
                    return null;
                  },
                  onChange: (String? newValue) {
                    dropDownProvider.dropdownValue = newValue!;
                    dropdownValue = newValue; // ? dropDownProvider.dropdownValue
                  },
                ),
                const SizedBox( height: 16 ),
                StyleElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  text: 'Save'
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}