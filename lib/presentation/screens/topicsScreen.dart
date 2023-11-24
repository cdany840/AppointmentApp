// ignore_for_file: file_names

import 'package:appointment_app/infrastructure/subs_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  
  List<String> userSubscriptions = [];

  final sc = SubsController();

  @override
  void initState() {
    super.initState();
    getUserSubscriptions();
  }

  void getUserSubscriptions() async {
    DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('subscriptions').doc(uid).get();

    if (!docSnapshot.exists) {
      // Si el documento no existe, créalo
      await FirebaseFirestore.instance.collection('subscriptions').doc(uid).set({'topics': []});
    }

    setState(() {
      userSubscriptions = List.from(docSnapshot.get('topics'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas de Interés'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('temasInteres').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          var temas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: temas.length,
            itemBuilder: (context, index) {
              var tema = temas[index].data(); // as Map<String, dynamic>; 
              bool isSubscribed = userSubscriptions.contains(tema['titulo']);

              return Container(
                margin: const EdgeInsets.all(8.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Text(tema['titulo']),
                  subtitle: Text(tema['presentacion']),
                  onTap: () {
                    // No necesitas lógica específica aquí si prefieres usar el Checkbox
                  },
                  trailing: Checkbox(
                    value: isSubscribed,
                    onChanged: (value) {
                      // Actualizar la suscripción al marcar/desmarcar el Checkbox
                      toggleSubscription(tema['titulo'], value ?? false);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void toggleSubscription(String topic, bool isSubscribed) async {
    CollectionReference subscriptions = FirebaseFirestore.instance.collection('subscriptions');

    if (isSubscribed) {
      subscriptions.doc(uid).update({
        'topics': FieldValue.arrayUnion([topic])
      }).then((value) {
        getUserSubscriptions(); // Actualizar la lista de suscripciones
        switch(topic){
          case '¡Mantente a la Vanguardia Tecnológica en Tu Negocio!':
            sc.subToTopic('tema1');
            break;
          case 'Conviértete en el Líder que Tu Equipo Necesita':
            sc.subToTopic('tema2');
            break;
          case 'Descubre el Secreto para una Gestión de Personal Exitosa':
            sc.subToTopic('tema3');
            break;
          case 'Transforma tu Estrategia de Marketing en un Éxito Rotundo':
            sc.subToTopic('tema4');
            break;
          case 'Gestión Financiera: La Clave del Éxito Empresarial':
            sc.subToTopic('tema5');
            break;
          case 'No te Quedes Atrás: Sigue las Últimas Tendencias del Mercado':
            sc.subToTopic('tema6');
            break;
          case 'Construye Relaciones Sólidas para el Éxito Empresarial':
            sc.subToTopic('tema7');
            break;
        }
      }).catchError((error) => error);
      
      sc.subToTopic(topic);
    } else {
      subscriptions.doc(uid).update({
        'topics': FieldValue.arrayRemove([topic])
      }).then((value) {
        getUserSubscriptions(); // Actualizar la lista de suscripciones
        switch(topic){
          case '¡Mantente a la Vanguardia Tecnológica en Tu Negocio!':
            sc.unsubToTopic('tema1');
            break;
          case 'Conviértete en el Líder que Tu Equipo Necesita':
            sc.unsubToTopic('tema2');
            break;
          case 'Descubre el Secreto para una Gestión de Personal Exitosa':
            sc.unsubToTopic('tema3');
            break;
          case 'Transforma tu Estrategia de Marketing en un Éxito Rotundo':
            sc.unsubToTopic('tema4');
            break;
          case 'Gestión Financiera: La Clave del Éxito Empresarial':
            sc.unsubToTopic('tema5');
            break;
          case 'No te Quedes Atrás: Sigue las Últimas Tendencias del Mercado':
            sc.unsubToTopic('tema6');
            break;
          case 'Construye Relaciones Sólidas para el Éxito Empresarial':
            sc.unsubToTopic('tema7');
            break;
        }
      }).catchError((error) => error);
      sc.unsubToTopic(topic);
    }
  }
}