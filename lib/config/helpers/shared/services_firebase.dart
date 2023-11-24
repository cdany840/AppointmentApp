import 'package:appointment_app/infrastructure/models/business_model.dart';
import 'package:appointment_app/infrastructure/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicesFirebase {

  ServicesFirebase({ required String collection }) : _collection = collection {
    uid = _auth.currentUser!.uid;
    _servicesCollection = _firebase.collection(_collection);
  }

  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  final String _collection;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference? _servicesCollection;
  static String uid = '';
  static String uidBusiness = '';

  Future<void> userSignOut() async {
    await _auth.signOut();
  }

  Future<void> insService(Map<String,dynamic> map) async{
    return _servicesCollection!.doc().set(map);
  }

  Future<void> updService(Map<String,dynamic> map, String uid) async {
    QuerySnapshot documents = await _servicesCollection!.where('uid_user', isEqualTo: uid).get();
    for (QueryDocumentSnapshot document in documents.docs) {
      DocumentReference docRef = _servicesCollection!.doc(document.id);
      await docRef.update(map);
    }
  }

  Future<void> delService(String id) async {
    return _servicesCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAll() {
    return _servicesCollection!.snapshots();
  }

  Future<ProfileModel?> getOneRecordProfile( String uid ) async {
    QuerySnapshot querySnapshot = await _servicesCollection!.where('uid_user', isEqualTo: uid).get();
    try {
      if (querySnapshot.docs.isNotEmpty) {
        return ProfileModel.fromJson( querySnapshot.docs.first.data() as Map<String, dynamic> );        
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }    
  }

  Future<BusinessModel?> getOneRecordBusiness( String uid ) async {
    QuerySnapshot querySnapshot = await _servicesCollection!.where('uid_user', isEqualTo: uid).get();
    try {
      return BusinessModel.fromJson( querySnapshot.docs.first.data() as Map<String, dynamic> );
    } catch (error) {
      return null;
    }
  }

  Future<String?> getUidBusiness( String uid ) async {
    QuerySnapshot querySnapshot = await _servicesCollection!.where('uid_user', isEqualTo: uid).get();
    try {
      return querySnapshot.docs.first.id;
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