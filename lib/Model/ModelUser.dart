import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ModelUser {
  // update profile ke collection Users Firestore
  Future<DocumentSnapshot> getUserInfo() async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(firebaseUser.uid)
        .get();
  }
}
