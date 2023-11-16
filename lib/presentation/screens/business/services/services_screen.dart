import 'package:appointment_app/config/helpers/business/services_firebase.dart';
import 'package:appointment_app/presentation/providers/form/form_provider.dart';
import 'package:appointment_app/presentation/widgets/custom/style_widgets.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/config/helpers/shared/regex.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {

  @override
  Widget build(BuildContext context) {
    final ServicesFirebase firebase = ServicesFirebase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.squarePlus),
            onPressed: () {              
              Navigator.pushNamed(context, '/add_service');
            },
          ),
        ],
      ),
      body: const Text('Services')
      // StreamBuilder(
      //   stream: firebase.getAllFavorites(),
      //   builder: (context, snapshot) {
      //     if(snapshot.hasData){
      //       return ListView.builder(
      //         itemCount: snapshot.data!.docs.length,
      //         itemBuilder: (context, index) {
      //           return Text(snapshot.data!.docs[index].get('title'));
      //         },
      //       );
      //     }else if(snapshot.hasError){
      //       return const Center(child: Text('Error en la petición, intente de nuevo!'),);
      //     } else { return const Center(child: CircularProgressIndicator(),);}
      //   },
      // ),
    );
  }
}