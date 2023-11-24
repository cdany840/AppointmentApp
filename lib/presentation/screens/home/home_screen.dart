import 'package:appointment_app/presentation/widgets/home/create_drawer.dart';
import 'package:flutter/material.dart';
import 'package:appointment_app/presentation/screens/citas/completadas.dart';
import 'package:appointment_app/presentation/screens/citas/nuevas.dart';
import 'package:appointment_app/presentation/screens/citas/pendientes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lottie/lottie.dart';

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
      backgroundColor: const Color.fromARGB(255, 43, 46, 48),
      bottomNavigationBar: CurvedNavigationBar(
        height: 55,
        backgroundColor: const Color.fromARGB(255, 43, 46, 48),
        color: const  Color.fromARGB(255, 18, 17, 17),
        animationDuration: const  Duration(milliseconds: 600),
        index: 0,
        onTap: (index){
          switch(index){
            case 0:
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
      drawer: const CreateDrawer(),
      body: Stack(
        children: [
           Align(
            alignment: Alignment.center,
            child: LottieBuilder.asset(
              "assets/animations/a.json",
              //height: 340,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: LottieBuilder.asset(
              "assets/animations/mxm.json",
              height: 340,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LottieBuilder.asset("assets/animations/tree.json"),
          ),
        ],
      ),
    );
  }
}