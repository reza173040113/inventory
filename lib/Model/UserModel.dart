import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class UserModel {
  Future<DocumentSnapshot> saveUser(
      String documentId, Map<String, dynamic> user) async {
    await Firebase.initializeApp();
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    users.doc(documentId).set(user).whenComplete(() {
      print("user sudah dibuat");
    });
  }

  // Future<DocumentSnapshot> updateUser( String uid, Map<String, dynamic> user) async {
  //   await Firebase.initializeApp();
  //  CollectionReference _fireStore = FirebaseFirestore.instance.collection('Users');
  // String documentID = '$uid';
  //   _fireStore.doc(documentID).updateData(user);
  // }

  Future<DocumentSnapshot> getUserInfo() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseUser.uid)
        .get();
  }
}
