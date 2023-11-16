import 'package:cloud_firestore/cloud_firestore.dart';

class ServicesFirebase {
  
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;
  CollectionReference? _servicesCollection;
  final String uid = '';

  ServicesFirebase(){
      _servicesCollection = _firebase.collection('posts');
  }

  Future<void> insService(Map<String,dynamic> map) async{
    return _servicesCollection!.doc(uid).set(map);
  }

  Future<void> updService(Map<String,dynamic> map, String id) async {
    return _servicesCollection!.doc(id).update(map);
  }

  Future<void> delService(String id) async {
    return _servicesCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFavorites() {
    return _servicesCollection!.snapshots();
  }

}