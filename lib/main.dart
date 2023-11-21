import 'package:appointment_app/config/theme/app_theme.dart';
import 'package:appointment_app/infrastructure/routes.dart';
import 'package:appointment_app/infrastructure/shared_preferences.dart';
import 'package:appointment_app/presentation/providers/form/form_provider.dart';
import 'package:appointment_app/presentation/providers/form/image_input_provider.dart';
import 'package:appointment_app/presentation/screens/home/home_screen.dart';
import 'package:appointment_app/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// * Config Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// * End

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.configPrefs();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
    print("Mensaje recibido: ${message.notification?.title}");
    _showNotification(message);
  });
  String? token = await messaging.getToken();
  print("Token: $token");

  runApp(
    const MyApp()

  );  
}

FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void _showNotification(RemoteMessage message) async{
  var androidInitialization = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings = InitializationSettings(android: androidInitialization);
  await _flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (payload){}
  );
  const String channelID = 'high_importance_channel';
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    channelID, 
    'High Importance Notifications',
    importance: Importance.max
  );
  AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
    channelID, 
    'High Importance Notifications',
    channelDescription: 'Channel description',
    importance: Importance.high,
    priority: Priority.high,
    ticker: 'ticker'
  );
  NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
  await _flutterLocalNotificationsPlugin.show(
    0, 
    message.notification?.title ?? 'Notificacion', 
    message.notification?.body ?? 'Cuerpo del Mensaje', 
    notificationDetails
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
        theme: AppTheme( selectedColor: 2, fontFamily: 'Lato' ).theme( Brightness.light ),
        darkTheme: AppTheme( selectedColor: 2 ).theme( Brightness.dark ),
        themeMode: MediaQuery.of(context).platformBrightness == Brightness.dark
          ? ThemeMode.dark // ? Should change the theme according to the device theme.
          : ThemeMode.light,
        home: Preferences.prefsSession.getBool('session') ?? false
          ? const HomeScreen() // * True
          : const LoginScreen(), // * False
      ),
    );
  }
}