import 'package:appointment_app/config/helpers/business/services_firebase.dart';
import 'package:appointment_app/infrastructure/models/profile_model.dart';
import 'package:appointment_app/presentation/providers/form/form_provider.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:appointment_app/presentation/widgets/shared/date_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/config/helpers/shared/regex.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  ServicesFirebase servicesFirebase = ServicesFirebase( collection: 'profile' );
  String? dropdownValue;
  final items = [ 'M', 'F', 'B' ];
  TextEditingController contName = TextEditingController();
  TextEditingController contSurnames = TextEditingController();
  TextEditingController contBirthday = TextEditingController();
  TextEditingController contPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dropDownProvider = context.watch<ProviderDropdown>();
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
                  hintText: 'Rodrigo',
                  labelText: 'Name',
                  controller: contName,
                  validator: (val) {
                    if (!val!.isValidName || val.isEmpty) {
                      return 'Please, enter a valid name.';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  hintText: 'Medina',
                  labelText: 'Surnames',
                  controller: contSurnames,
                  validator: (val) {
                    if (!val!.isValidName || val.isEmpty) {
                      return 'Please, enter a valid surnames.';
                    }
                    return null;
                  }                  
                ),
                const SizedBox( height: 16 ),
                DateInputField(
                  controller: contBirthday,
                  icon: Icons.calendar_today,
                  label: 'Birthday Date',
                  hint: '12/12/1212',
                  onDateSelected: (DateTime selectedDate) {
                    
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please, enter a valid date.';
                    }
                    return null;
                  }
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  keyboardType: TextInputType.phone,
                  hintText: '0000 - 000 - 000 - 000',
                  labelText: 'Phone Number',
                  controller: contPhone,
                  validator: (val) {
                    if (!val!.isValidPhone || val.isEmpty) {
                      return 'Please, enter a valid phone number.';
                    }
                    return null;
                  }
                ),
                const SizedBox( height: 16 ),
                StyleDropdownButtonFormField(
                  labelText: 'Gender', 
                  hintText: 'M or F or B',
                  value: dropdownValue,
                  items: items,                  
                  validator: (val) {
                    if (val == null) {
                      return 'Please, choose a gender.';
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
                  onPressed: () async {
                    ProfileModel profile = ProfileModel(
                      idUser: ServicesFirebase.uid,
                      name: contName.text,
                      surnames: contSurnames.text,
                      phoneNumber: int.parse(contPhone.text),
                      birthdayDate: DateFormat("yyyy-dd-mm").parseLoose(contBirthday.text),
                      gender: dropdownValue,
                    );
                    if (_formKey.currentState!.validate()) {                      
                      await servicesFirebase.insService(
                        profile.toJson()
                      );
                      _formKey.currentState?.reset();
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