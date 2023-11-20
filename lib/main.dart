import 'package:appointment_app/config/theme/app_theme.dart';
import 'package:appointment_app/infrastructure/routes.dart';
import 'package:appointment_app/infrastructure/shared_preferences.dart';
import 'package:appointment_app/presentation/providers/form/form_provider.dart';
import 'package:appointment_app/presentation/providers/form/image_input_provider.dart';
import 'package:appointment_app/presentation/screens/home/home_screen.dart';
import 'package:appointment_app/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// * Config Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// * End

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.configPrefs();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp()

  );
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // * font - double fontSize = MediaQuery.of(context).size.width * 0.05;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (_) => ProviderDropdown() ),
        ChangeNotifierProvider( create: (_) => ProviderInputTime() ),
        ChangeNotifierProvider( create: (_) => ImageInputProvider() ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: getRoutes(),
        title: 'AppointmentApp',
        theme: AppTheme( selectedColor: 2, fontFamily: 'Agbalumo' ).theme( Brightness.light ),
        darkTheme: AppTheme( selectedColor: 2 ).theme( Brightness.dark ),
        home: Preferences.prefsSession.getBool('session') ?? false
                ? const HomeScreen() // * True
                : const LoginScreen(), // * False
      ),
    );
  }
}