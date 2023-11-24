import 'package:appointment_app/presentation/screens/citas/completadas.dart';
import 'package:appointment_app/presentation/screens/citas/nuevas.dart';
import 'package:appointment_app/presentation/screens/citas/pendientes.dart';
import 'package:appointment_app/presentation/widgets/home/create_drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {  
  // static String uid = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey,
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor: Colors.blueGrey,
        color: Colors.blueGrey.shade100,
        animationDuration: Duration(milliseconds: 600),
        index: 0,
        onTap: (index){
          switch(index){
            case 0:
            break;
            case 1:
              Future.delayed(Duration(milliseconds: 600), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => citasNuevas(),
                    settings: RouteSettings(name: '/cnuevas'),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                    transitionDuration: Duration(milliseconds: 0), // Establecer la duración a 0 para desactivar la transición
                  ),
                );
              });
            break;
            case 2:
              Future.delayed(Duration(milliseconds: 600), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => citasPendientes(),
                    settings: RouteSettings(name: '/cpendientes'),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                    transitionDuration: Duration(milliseconds: 0), // Establecer la duración a 0 para desactivar la transición
                  ),
                );
              });
            break;
            case 3:
                Future.delayed(Duration(milliseconds: 600), () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => citasCompletadas(),
                    settings: RouteSettings(name: '/ccompletadas'),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                    transitionDuration: Duration(milliseconds: 0), // Establecer la duración a 0 para desactivar la transición
                  ),
                );
              });
            break;
            default:
            print('nada');
          }
        },
        items: [
          Icon(Icons.home, color: Colors.blueGrey,),
          Icon(Icons.add_rounded, color: Colors.blueGrey,),
          Icon(Icons.access_time_rounded, color: Colors.blueGrey,),
          Icon(Icons.beenhere_outlined, color: Colors.blueGrey,),
        ]
      ),
      drawer: const CreateDrawer(),
      body: Container(),
    );
  }
}