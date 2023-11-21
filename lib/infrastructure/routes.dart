import 'package:appointment_app/presentation/screens/business/business_screen.dart';
import 'package:appointment_app/presentation/screens/business/services/add_services.dart';
import 'package:appointment_app/presentation/screens/business/services/services_screen.dart';
import 'package:appointment_app/presentation/screens/home/home_screen.dart';
import 'package:appointment_app/presentation/screens/login/forgot_pass_screen.dart';
import 'package:appointment_app/presentation/screens/login/login_screen.dart';
import 'package:appointment_app/presentation/screens/login/register_screen.dart';
import 'package:appointment_app/presentation/screens/profile/profile_screen.dart';
import 'package:appointment_app/presentation/screens/subscriptions/topicsScreen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes(){
  return{
    '/login' : (BuildContext context) => const LoginScreen(),
    '/register' : (BuildContext context) => const RegisterScreen(),
    '/home' : (BuildContext context) => const HomeScreen(),
    '/forgot' : (BuildContext context) => const ForgotPassScreen(),
    '/profile' : (BuildContext context) => const ProfileScreen(),
    '/business' : (BuildContext context) => const BusinessScreen(),
    '/services' : (BuildContext context) => const ServicesScreen(),
    '/add_service' : (BuildContext context) => const AddService(),
    '/subs' : (BuildContext context) => const topicsScreen(),
  };
}