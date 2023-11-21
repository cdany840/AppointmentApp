import 'package:appointment_app/infrastructure/subs_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class topicsScreen extends StatefulWidget {
  const topicsScreen({super.key});

  @override
  State<topicsScreen> createState() => _topicsScreenState();
}

class _topicsScreenState extends State<topicsScreen> {
  final String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
  
  List<String> userSubscriptions = [];

  final sc = subsController();

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
        title: Text('Temas de Interés'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('temasInteres').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var temas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: temas.length,
            itemBuilder: (context, index) {
              var tema = temas[index].data() as Map<String, dynamic>;
              bool isSubscribed = userSubscriptions.contains(tema['titulo']);

              return Container(
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
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
        print('Suscrito a $topic exitosamente');
        getUserSubscriptions(); // Actualizar la lista de suscripciones
        switch(topic){
          case '¡Mantente a la Vanguardia Tecnológica en Tu Negocio!':
            print("sub al tema1");
            sc.subToTopic('tema1');
            break;
          case 'Conviértete en el Líder que Tu Equipo Necesita':
            print("sub al tema2");
            sc.subToTopic('tema2');
            break;
          case 'Descubre el Secreto para una Gestión de Personal Exitosa':
            print("sub al tema3");
            sc.subToTopic('tema3');
            break;
          case 'Transforma tu Estrategia de Marketing en un Éxito Rotundo':
            print("sub al tema4");
            sc.subToTopic('tema4');
            break;
          case 'Gestión Financiera: La Clave del Éxito Empresarial':
            print("sub al tema5");
            sc.subToTopic('tema5');
            break;
          case 'No te Quedes Atrás: Sigue las Últimas Tendencias del Mercado':
            print("sub al tema6");
            sc.subToTopic('tema6');
            break;
          case 'Construye Relaciones Sólidas para el Éxito Empresarial':
            print("sub al tema7");
            sc.subToTopic('tema7');
            break;
        }
      }).catchError((error) => print('Error al suscribirse: $error'));
      
      sc.subToTopic(topic);
    } else {
      subscriptions.doc(uid).update({
        'topics': FieldValue.arrayRemove([topic])
      }).then((value) {
        print('Desuscripción de $topic exitosa');
        getUserSubscriptions(); // Actualizar la lista de suscripciones
        switch(topic){
          case '¡Mantente a la Vanguardia Tecnológica en Tu Negocio!':
            print("unsub al tema1");
            sc.unsubToTopic('tema1');
            break;
          case 'Conviértete en el Líder que Tu Equipo Necesita':
            print("unsub al tema2");
            sc.unsubToTopic('tema2');
            break;
          case 'Descubre el Secreto para una Gestión de Personal Exitosa':
            print("unsub al tema3");
            sc.unsubToTopic('tema3');
            break;
          case 'Transforma tu Estrategia de Marketing en un Éxito Rotundo':
            print("unsub al tema4");
            sc.unsubToTopic('tema4');
            break;
          case 'Gestión Financiera: La Clave del Éxito Empresarial':
            print("unsub al tema5");
            sc.unsubToTopic('tema5');
            break;
          case 'No te Quedes Atrás: Sigue las Últimas Tendencias del Mercado':
            print("unsub al tema6");
            sc.unsubToTopic('tema6');
            break;
          case 'Construye Relaciones Sólidas para el Éxito Empresarial':
            print("unsub al tema7");
            sc.unsubToTopic('tema7');
            break;
        }
      }).catchError((error) => print('Error al desuscribirse: $error'));
      sc.unsubToTopic(topic);
    }
  }
}