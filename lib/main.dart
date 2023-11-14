import 'package:appointment_app/config/theme/app_theme.dart';
import 'package:appointment_app/infrastructure/routes.dart';
import 'package:appointment_app/presentation/providers/login/login_provider.dart';
import 'package:appointment_app/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// * Config Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// * End

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp()

  );
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: getRoutes(),
        title: 'AppointmentAoo',
        theme: AppTheme( selectedColor: 2 ).theme( Brightness.light ),
        darkTheme: AppTheme( selectedColor: 2 ).theme( Brightness.dark ),
        home: const LoginScreen()
      ),
    );
  }
}