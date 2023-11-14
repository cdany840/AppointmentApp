import 'package:appointment_app/presentation/screens/login/login_screen.dart';
import 'package:appointment_app/presentation/screens/login/register_screen.dart';
import 'package:appointment_app/test.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes(){
  return{
    '/login' : (BuildContext context) => const LoginScreen(),
    '/register' : (BuildContext context) => const RegisterScreen(),
    '/home' : (BuildContext context) => const HomeScreen(),
  };
}