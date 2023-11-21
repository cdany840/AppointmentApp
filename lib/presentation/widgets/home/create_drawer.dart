import 'package:appointment_app/infrastructure/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateDrawer extends StatelessWidget {
  const CreateDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/333'),
            ),
            accountName: Text('Name User'), 
            accountEmail: Text('user_email@gmail.com')
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
          ListTile(
            leading: const Icon(FontAwesomeIcons.rectangleList),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Interesting topics'),
            subtitle: const Text('Subscribe'),
            onTap: () {
              Navigator.pushNamed(context, '/subs');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesomeIcons.rectangleList),
            trailing: const Icon(Icons.chevron_right),
            title: const Text('Logout'),
            subtitle: const Text('Cerrar sesion'),
            onTap: () {
              Preferences.prefsSession.setBool('session', false);
              Navigator.pushNamed(context, '/login');
            },
          ),
        ],
      ),
    );
  }
}