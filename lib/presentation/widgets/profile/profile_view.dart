import 'package:appointment_app/config/helpers/business/services_firebase.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final ServicesFirebase servicesFirebase = ServicesFirebase( collection: 'profile' );

  String formatPhoneNumber(int phoneNumber) {
    String phoneNumberString = phoneNumber.toString();
    String formattedPhoneNumber =
        "${phoneNumberString.substring(0, 3)}-${phoneNumberString.substring(3, 6)}-${phoneNumberString.substring(6)}";
    return formattedPhoneNumber;
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: servicesFirebase.getOneData( ServicesFirebase.uid ),
      builder: (context, snapshot) {
        final profile = snapshot.data;
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only( top: 20),
                  height: screenHeight * 0.2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      imageUrl: profile!.image!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox( height: 20 ),
                Text(
                  '${profile.name!} ${profile.surnames!}',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox( height: 10 ),
                RowProfile(
                  text: formatPhoneNumber(profile.phoneNumber!),
                  icon: FontAwesomeIcons.phone
                ),
                const SizedBox( height: 10 ),
                const SizedBox( height: 10 ),
                RowProfile(
                  text: profile.gender! == 'M' ? 'Male' : 'Female',
                  icon: FontAwesomeIcons.venus
                ),
                RowProfile(
                  text: calculateAge(profile.birthdayDate!).toString(),
                  icon: FontAwesomeIcons.cakeCandles
                ),
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