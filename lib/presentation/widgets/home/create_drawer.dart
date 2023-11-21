import 'package:appointment_app/config/helpers/business/services_firebase.dart';
import 'package:appointment_app/infrastructure/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateDrawer extends StatefulWidget {
  const CreateDrawer({super.key});

  @override
  State<CreateDrawer> createState() => _CreateDrawerState();
}

class _CreateDrawerState extends State<CreateDrawer> {
  ServicesFirebase servicesFirebase = ServicesFirebase( collection: 'profile' );
  final User? user = FirebaseAuth.instance.currentUser;
  bool getLogin() {
    return  Preferences.prefsLogin.getString('login') == 'Google' || Preferences.prefsLogin.getString('login') == 'Github';
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          FutureBuilder(
            future: servicesFirebase.getOneData( ServicesFirebase.uid ),
            builder: (context, snapshot) {
              if (snapshot.hasData || getLogin()) {
                return UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: CachedNetworkImageProvider(
                      getLogin() ? user!.photoURL! : snapshot.data!.image!,
                      errorListener: (error) => const Icon(Icons.error),
                    )
                  ),
                  accountName: Text( getLogin() ? user!.displayName! : snapshot.data!.name!),
                  accountEmail: Text( getLogin() ? user!.email! : snapshot.data!.surnames!)
                );  
              }
              return const Text('Loading Data...');
            }
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