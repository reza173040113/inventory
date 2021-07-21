import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Model/UserModel.dart';

class UserController {
  UserModel userModel = new UserModel();

  // Future<DocumentSnapshot> userUpdate(
  //     String displayName, String phoneNumber, String userId, String pic) async {
  //   Map<String, dynamic> user = {
  //     "displayName": displayName,
  //     "phoneNumber": phoneNumber,
  //     "uid": userId,
  //     "pic": pic,
  //   };
  //   userModel.updateUser(userId, user);
  // }

  Future<DocumentSnapshot> userSetup(
      String displayName, String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String documentId = auth.currentUser.uid.toString();
    String email = auth.currentUser.email.toString();
    String pic = "";
    Map<String, dynamic> user = {
      "displayName": displayName,
      "phoneNumber": phoneNumber,
      "email": email,
      "uid": documentId,
      "role": 1,
      "pic": pic,
    };
    userModel.saveUser(documentId, user);
  }

  String getTglPinjam(tglPinjam) {
    return tglPinjam;
  }
}
