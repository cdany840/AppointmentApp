import 'package:appointment_app/config/helpers/shared/services_firebase.dart';
import 'package:appointment_app/infrastructure/models/service_model.dart';
import 'package:appointment_app/presentation/providers/form/provider_image_input.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:appointment_app/presentation/widgets/shared/image_input.dart';
import 'package:appointment_app/presentation/widgets/shared/toast.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/config/helpers/shared/regex.dart';
import 'package:provider/provider.dart';

class ServiceForm extends StatefulWidget {
  const ServiceForm({super.key, this.serviceModel});
  final ServiceModel? serviceModel;

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final _formKey = GlobalKey<FormState>();  
  ServicesFirebase servicesFirebase = ServicesFirebase(collection: 'service');
  TextEditingController contName = TextEditingController();
  TextEditingController contDescription = TextEditingController();
  TextEditingController contDuration  = TextEditingController();
  TextEditingController contPrice  = TextEditingController();
  void resetForm() {
    contName.clear();
    contDescription.clear();
    contDuration.clear();
    contPrice.clear();
  }

  @override
  void initState() {
    if (widget.serviceModel != null) {
      contName.text = widget.serviceModel!.serviceName!;
      contDescription.text = widget.serviceModel!.serviceDescription!;
      contDuration.text = widget.serviceModel!.serviceDuration!;
      contPrice.text = widget.serviceModel!.servicePrice.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectImage = context.watch<ProviderImageInput>();
    return WillPopScope(
      onWillPop: () async {
        selectImage.resetImage();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: widget.serviceModel == null ? const Text('Create Service') : const Text('Edit Service'),
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
                  widget.serviceModel != null
                  ? ImageInput( imageUrl: widget.serviceModel!.image )
                  : const ImageInput( imageUrl: 'https://cdn-icons-png.flaticon.com/512/2720/2720641.png' ),
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
                      if (val!.isEmpty) {
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
                    onPressed: () async {
                      selectImage.folder = 'service';
                      if (widget.serviceModel != null) selectImage.imageUrl = widget.serviceModel!.image;
                      ServiceModel service = ServiceModel(
                        uidBusiness: ServicesFirebase.uid,
                        serviceName: contName.text,
                        serviceDescription: contDescription.text,
                        serviceDuration: contDuration.text,
                        servicePrice: double.parse(contPrice.text),
                        image: selectImage.imageUrl
                      );
                      if (_formKey.currentState!.validate()) {
                        if (widget.serviceModel != null) {
                          await servicesFirebase.updService(
                            service.toJson(),
                            widget.serviceModel!.serviceName!
                          );                        
                        } else {
                          await servicesFirebase.insDocument(
                            service.toJson()
                          );
                        }
                        resetForm();
                        selectImage.resetImage();
                        Navigator.pushNamed(context, '/services');
                        WidgetToast.show('Service Save');
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