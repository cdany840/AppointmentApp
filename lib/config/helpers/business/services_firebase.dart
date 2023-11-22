import 'package:appointment_app/infrastructure/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicesFirebase {

  ServicesFirebase({ required this.collection }) {
    uid = _auth.currentUser!.uid;
    _servicesCollection = _firebase.collection(collection);
  }

  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final String collection;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference? _servicesCollection;
  static String uid = '';

  Future<void> insService(Map<String,dynamic> map) async{
    return _servicesCollection!.doc().set(map);
  }

  Future<void> updService(Map<String,dynamic> map, String id) async {
    return _servicesCollection!.doc(id).update(map);
  }

  Future<void> delService(String id) async {
    return _servicesCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAll() {
    return _servicesCollection!.snapshots();
  }

  Future<ProfileModel?> getDataProfile( String uid ) async {
    QuerySnapshot querySnapshot = await _servicesCollection!.where("iduser", isEqualTo: uid).get();
    try {
      return ProfileModel.fromJson( querySnapshot.docs.first.data() as Map<String, dynamic> );    
    } catch (error) {
      return null;
    }
  }

  Stream<Map<String, dynamic>> getDataStream() {
    DocumentReference docRef = _servicesCollection!.doc( uid );
    return docRef.snapshots().map((DocumentSnapshot snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return data;
      } else {
        return Map<String, dynamic>.from({});
      }
    });
  }

}