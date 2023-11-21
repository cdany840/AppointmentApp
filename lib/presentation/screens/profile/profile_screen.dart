import 'package:appointment_app/presentation/providers/form/form_provider.dart';
import 'package:appointment_app/presentation/providers/form/image_input_provider.dart';
import 'package:appointment_app/presentation/widgets/profile/profile_form.dart';
import 'package:appointment_app/presentation/widgets/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final selectScren = context.watch<ProviderScreenProfile>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          Visibility(
            visible: selectScren.screen,
            child: IconButton(
              onPressed: () => selectScren.screen = !selectScren.screen,
              icon: const Icon(FontAwesomeIcons.penToSquare)
            ),
          )
        ],
      ),
      body: !selectScren.screen ? const ProfileForm(edit: true) : ProfileView(),
    );
  }
}