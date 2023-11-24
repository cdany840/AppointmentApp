import 'package:appointment_app/config/helpers/shared/services_firebase.dart';
import 'package:appointment_app/presentation/widgets/business/business_form.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BusinessView extends StatelessWidget {
  BusinessView({super.key});
  final ServicesFirebase servicesFirebase = ServicesFirebase( collection: 'business' );

  String formatPhoneNumber(int phoneNumber) {
    String phoneNumberString = phoneNumber.toString();
    String formattedPhoneNumber =
        "${phoneNumberString.substring(0, 3)}-${phoneNumberString.substring(3, 6)}-${phoneNumberString.substring(6)}";
    return formattedPhoneNumber;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: servicesFirebase.getOneRecordBusiness( ServicesFirebase.uid ),
      builder: (context, snapshot) {
        final business = snapshot.data;
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ContainerImage(
                  imageUrl: business!.image!
                ),
                const SizedBox( height: 20 ),
                Text(
                  '${business.businessName} - ${business.brandName}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox( height: 10 ),
                RowProfile(
                  text: business.businessAddress!,
                  icon: FontAwesomeIcons.mapLocationDot
                ),
                const SizedBox( height: 10 ),
                Visibility(
                  visible: business.apartmentOffice != '',
                  child: RowProfile(
                    text: business.apartmentOffice!,
                    icon: FontAwesomeIcons.building
                  ),
                ),
                const SizedBox( height: 10 ),
                RowProfile(
                  text: formatPhoneNumber(business.businessPhone!),
                  icon: FontAwesomeIcons.phone
                ),
                const SizedBox( height: 10 ),
                RowProfile(
                  text: business.businessEmail!,
                  icon: FontAwesomeIcons.envelope
                ),
                const SizedBox( height: 10 ),
                RowProfile(
                  text: business.businessType!,
                  icon: FontAwesomeIcons.businessTime
                ),
                const SizedBox( height: 16 ),
                StyleElevatedButton(
                  text: 'Edit Business',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BusinessForm( businessModel: business ))
                    );                    
                  }
                )
              ],              
            )
          );
        }
        return const Text('Loading Data...');
      }
    );
  }
}

class RowProfile extends StatelessWidget {
  const RowProfile({
    super.key,
    required this.text,
    required this.icon
  });
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon),
        const SizedBox( width: 15),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }
}