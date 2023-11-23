import 'package:appointment_app/config/helpers/business/services_firebase.dart';
import 'package:appointment_app/infrastructure/models/business_model.dart';
import 'package:appointment_app/presentation/providers/form/form_provider.dart';
import 'package:appointment_app/presentation/providers/form/image_input_provider.dart';
import 'package:appointment_app/presentation/widgets/business/business_map.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:appointment_app/presentation/widgets/shared/image_input.dart';
import 'package:appointment_app/presentation/widgets/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/config/helpers/shared/regex.dart';
import 'package:provider/provider.dart';

class BusinessForm extends StatefulWidget {
  const BusinessForm({super.key, this.businessModel});
  final BusinessModel? businessModel;

  @override
  State<BusinessForm> createState() => _BusinessFormState();
}

class _BusinessFormState extends State<BusinessForm> {
  final _formKey = GlobalKey<FormState>();
  final ServicesFirebase servicesFirebase = ServicesFirebase( collection: 'business' );
  String? dropdownValue;
  final items = [ 'Aesthetics', 'Office', 'Mechanic', 'Restaurant', 'Dentist' ];
  TextEditingController contName = TextEditingController();
  TextEditingController contBrand = TextEditingController();
  TextEditingController contAddress = TextEditingController();
  TextEditingController contEmail = TextEditingController();
  TextEditingController contApartment = TextEditingController();
  TextEditingController contPhone = TextEditingController();
  TextEditingController contLocation = TextEditingController();
  void resetForm() {
    dropdownValue = null;
    contName.clear();
    contBrand.clear();
    contAddress.clear();
    contEmail.clear();
    contApartment.clear();
    contPhone.clear();
    contLocation.clear();
  }

  @override
  void initState() {
    if (widget.businessModel != null) {
      final business = widget.businessModel!;
      dropdownValue = business.businessType;
      contName.text = business.businessName!;
      contBrand.text = business.brandName!;
      contAddress.text = business.businessAddress!;
      contEmail.text = business.businessEmail!;
      contApartment.text = business.apartmentOffice!;
      contPhone.text = business.businessPhone.toString();
      contLocation.text = business.location!;
    }    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dropDownProvider = context.watch<ProviderDropdown>();
    final selectImage = context.watch<ImageInputProvider>();
    return WillPopScope(
      onWillPop: () async {
        selectImage.resetImage();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: widget.businessModel == null ? const Text('Create Business') : const Text('Edit Business'),
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
                  ImageInput( imageUrl: widget.businessModel!.image ),
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
                    controller: contBrand,
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
                  StyleTextFormField(
                    hintText: '0.000000, 0.000000',
                    readOnly: true,
                    labelText: 'Location',
                    controller: contLocation,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please, select a location.';
                      }
                      return null;
                    },
                  ),
                  StyleElevatedButton(
                    onPressed: () async {                    
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BusinessMap()),
                      );
                      contLocation.text = result.toString();
                    },
                    text: 'Select Location'
                  ),
                  const SizedBox( height: 16 ),
                  StyleElevatedButton(
                    onPressed: () async {
                      if (widget.businessModel != null) selectImage.imageUrl = widget.businessModel!.image;
                      BusinessModel business = BusinessModel(
                        uidUser: ServicesFirebase.uid,
                        businessName: contName.text,
                        brandName: contBrand.text,
                        businessAddress: contAddress.text,
                        apartmentOffice: contApartment.text,
                        businessPhone: int.parse(contPhone.text),
                        businessEmail: contEmail.text,
                        businessType: dropdownValue,
                        location: contLocation.text,
                        image: selectImage.imageUrl
                      );
                      if (_formKey.currentState!.validate()) {
                        if (widget.businessModel != null) {
                          await servicesFirebase.updService(
                            business.toJson(),
                            ServicesFirebase.uid
                          );                        
                        } else {
                          await servicesFirebase.insService(
                            business.toJson()
                          );                        
                        }
                        resetForm();
                        selectImage.resetImage();
                        Navigator.pushNamed(context, '/home');
                        WidgetToast.show('Business Save');
                      }
                    },
                    text: 'Save'
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}