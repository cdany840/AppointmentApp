import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:appointment_app/presentation/widgets/shared/date_input.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/config/helpers/shared/regex.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _formKey = GlobalKey<FormState>();
  String? dropdownValue;
  final items = [ 'Aesthetics', 'Office', 'Mechanic', 'Restaurant', 'Dentist' ];
  TextEditingController contName = TextEditingController();
  TextEditingController contDescription = TextEditingController();
  TextEditingController contDuration  = TextEditingController();
  TextEditingController contPrice  = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  hintText: 'Hair Ironing',
                  labelText: 'Service Name',
                  controller: contName,
                  validator: (val) {
                    if (!val!.isValidName || val.isEmpty) {
                      return 'Please, enter a valid service name.';
                    }
                    return null;
                  },
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  hintText: 'Hair straightening is a service commonly offered in beauty salons and esthetics that aims to achieve smooth and silky hair through the use of a thermal iron. This procedure is particularly popular among individuals with curly or frizzy hair who desire a more polished and manageable look.',
                  maxLines: 5,
                  labelText: 'Description',
                  controller: contDescription,
                  validator: (val) {
                    if (!val!.isValidName || val.isEmpty) {
                      return 'Please, enter a valid description.';
                    }
                    return null;
                  }                  
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  hintText: '00:10 to 09:00',
                  labelText: 'Approximate Duration',
                  keyboardType: TextInputType.datetime,
                  controller: contDuration,
                  validator: (val) {
                    if (!val!.isValidHour || val.isEmpty) {
                      return 'Please, enter a valid approximate duration.';
                    }
                    return null;
                  }
                ),
                const SizedBox( height: 16 ),
                StyleTextFormField(
                  hintText: '\$ 100.00',
                  labelText: 'Service Price',
                  keyboardType: TextInputType.number,
                  controller: contPrice,
                  validator: (val) {
                    if (!val!.isValidPrice || val.isEmpty) {
                      return 'Please, enter a valid service price.';
                    }
                    return null;
                  }
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