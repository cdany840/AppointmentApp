import 'package:appointment_app/config/helpers/business/services_firebase.dart';
import 'package:appointment_app/infrastructure/models/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateDrawer extends StatefulWidget {
  const CreateDrawer({super.key});

  @override
  State<CreateDrawer> createState() => _CreateDrawerState();
}

class _CreateDrawerState extends State<CreateDrawer> {

  ServicesFirebase servicesFirebase = ServicesFirebase( collection: 'profile' );
  ProfileModel profileModel = ProfileModel();  

  @override
  void initState() {
    servicesFirebase.getOneData( ServicesFirebase.uid ).then((value) => profileModel = value!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {    
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/301'),
            ),
            accountName: Text(profileModel.name!), 
            accountEmail: Text(profileModel.surnames!)
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.addressCard),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Edit Profile'),
            subtitle: const Text('User Data'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.businessTime),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Edit Business'),
            subtitle: const Text('Merchants Data'),
            onTap: () {
              Navigator.pushNamed(context, '/business');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.rectangleList),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('See Services'),
            subtitle: const Text('Add new'),
            onTap: () {
              Navigator.pushNamed(context, '/services');
            },
          ),
        ],
      ),
    );
  }
}