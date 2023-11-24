import 'package:appointment_app/presentation/screens/citas/nuevas.dart';
import 'package:appointment_app/presentation/screens/citas/pendientes.dart';
import 'package:appointment_app/presentation/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CitasCompletadas extends StatefulWidget {
  const CitasCompletadas({super.key});

  @override
  State<CitasCompletadas> createState() => _CitasCompletadasState();
}

class _CitasCompletadasState extends State<CitasCompletadas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 43, 46, 48),
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor:  const Color.fromARGB(255, 43, 46, 48),
        color: const  Color.fromARGB(255, 18, 17, 17),
        animationDuration: const  Duration(milliseconds: 600),
        index: 3,
        onTap: (index){
          switch(index){
            case 0:
            Future.delayed( const Duration(milliseconds: 600), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const  HomeScreen(),
                    settings:  const RouteSettings(name: '/home'),
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
              Future.delayed( const Duration(milliseconds: 600), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => const  CitasPendientes(),
                    settings: const  RouteSettings(name: '/cpendientes'),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                    transitionDuration: const  Duration(milliseconds: 0), // Establecer la duración a 0 para desactivar la transición
                  ),
                );
              });
            break;
            case 3:
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
      body:  Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: LottieBuilder.asset("assets/animations/a.json"),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('completadas').snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData){
                return const CircularProgressIndicator();
              }
              var newcitas = snapshot.data!.docs;
              return ListView.builder(
                itemCount: newcitas.length,
                itemBuilder: (context, index){
                  var cita = newcitas[index].data();
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
                        style: const  TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  );
                });
            },
          ),
        ],
      )
    );
  }
}