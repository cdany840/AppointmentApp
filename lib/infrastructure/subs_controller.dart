import 'package:firebase_messaging/firebase_messaging.dart';
class SubsController{
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> subToTopic(String topic) async{
    await _firebaseMessaging.subscribeToTopic(topic);
  }
  Future<void> unsubToTopic(String topic) async{
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }
}