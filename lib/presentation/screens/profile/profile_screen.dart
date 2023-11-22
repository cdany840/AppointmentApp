import 'package:appointment_app/presentation/widgets/profile/profile_form.dart';
import 'package:appointment_app/presentation/widgets/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileForm( edit: true )),
              );
            },
            icon: const Icon(FontAwesomeIcons.penToSquare)
          )
        ],
      ),
      body: ProfileView(),
    );
  }
}