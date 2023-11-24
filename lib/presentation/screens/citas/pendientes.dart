import 'package:appointment_app/presentation/screens/citas/completadas.dart';
import 'package:appointment_app/presentation/screens/citas/nuevas.dart';
import 'package:appointment_app/presentation/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CitasPendientes extends StatefulWidget {
  const CitasPendientes({super.key});

  @override
  State<CitasPendientes> createState() => _CitasPendientesState();
}

class _CitasPendientesState extends State<CitasPendientes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 46, 48),
      body:  Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LottieBuilder.asset("assets/animations/a.json"),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('pendientes').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const CircularProgressIndicator();
              }
              var pendCitas = snapshot.data!.docs;
              return ListView.builder(
                itemCount: pendCitas.length,
                itemBuilder: (context, index){
                  var cita = pendCitas[index].data();
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      title: Text(
                        cita['name'],
                        style:  const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        cita['desc'],
                        style:  const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:  const Icon(
                              Icons.beenhere_outlined,
                              color: Colors.green,
                            ),
                            onPressed: (){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const  Text("Terminar Cita"),
                                    content: const  Text("¿Estás seguro de que quieres marcar como completada esta cita?"),
                                    actions: [
                                      TextButton(
                                        child: const  Text("Cancelar"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const  Text("Aceptar"),
                                        onPressed: () async {
                                          // Obtener la referencia al documento
                                          DocumentReference documentReference = FirebaseFirestore.instance.collection('pendientes').doc(pendCitas[index].id);

                                          // Obtener los datos del documento
                                          DocumentSnapshot documentSnapshot = await documentReference.get();
                                          Map<String, dynamic>? citaData = documentSnapshot.data() as Map<String, dynamic>?;

                                          if (citaData != null) {
                                            // Agregar los datos a la colección 'pendientes'
                                            await FirebaseFirestore.instance.collection('completadas').add(citaData);

                                            // Eliminar el documento de la colección 'nuevas'
                                            await documentReference.delete();
                                          }

                                          // Cerrar el diálogo
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }, 
                          ),
                        ],
                      ),
                    ),
                  );
                });
            },
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor: const Color.fromARGB(255, 43, 46, 48),
        color: const  Color.fromARGB(255, 18, 17, 17),
        animationDuration: const  Duration(milliseconds: 600),
        index: 2,
        onTap: (index){
          switch(index){
            case 0:
            Future.delayed( const Duration(milliseconds: 600), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>  const HomeScreen(),
                    settings: const  RouteSettings(name: '/home'),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                    transitionDuration: const  Duration(milliseconds: 0), // Establecer la duración a 0 para desactivar la transición
                  ),
                );
              });
            break;
            case 1:
              Future.delayed( const Duration(milliseconds: 600), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const  CitasNuevas(),
                    settings: const  RouteSettings(name: '/cnuevas'),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                    transitionDuration: const  Duration(milliseconds: 0), // Establecer la duración a 0 para desactivar la transición
                  ),
                );
              });
            break;
            case 2:
            break;
            case 3:
                Future.delayed( const Duration(milliseconds: 600), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const  CitasCompletadas(),
                    settings: const  RouteSettings(name: '/ccompletadas'),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                    transitionDuration: const  Duration(milliseconds: 0), // Establecer la duración a 0 para desactivar la transición
                  ),
                );
              });
            break;
            default:
            //print('nada');
          }
        },
        items:  const [
          Icon(Icons.home, color: Color.fromARGB(255, 139, 139, 139),),
          Icon(Icons.add_rounded, color:  Color.fromARGB(255, 139, 139, 139),),
          Icon(Icons.access_time_rounded, color:  Color.fromARGB(255, 139, 139, 139),),
          Icon(Icons.beenhere_outlined, color:  Color.fromARGB(255, 139, 139, 139),),
        ]
      ),
    );
  }
}