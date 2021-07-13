import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inventory/Controller/UserController.dart';
import 'package:inventory/HalamanUtama.dart';

import 'AppTheme.dart';

class AuthState with ChangeNotifier {
  bool authProcess = false;
  bool autoValidate = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController displayName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final key = GlobalKey<FormState>();
  final String argument;
  final BuildContext context;
  final AppTheme _theme = new AppTheme();
  UserController userController = new UserController();

  AuthState(this.argument, this.context);

  auth() {
    if (key.currentState.validate()) {
      authProcess = true;
      notifyListeners();
      if (argument == "register")
        _register();
      else
        _login();
    } else {
      autoValidate = true;
      notifyListeners();
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  _dialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: _theme.buttonTheme(),
          content: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Auth Failed",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                Padding(padding: EdgeInsets.only(top: 16)),
                Text(message),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  width: 150,
                  height: 40,
                  child: RaisedButton(
                    color: _theme.appColors[red],
                    textColor: _theme.appColors[white],
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                    shape: _theme.buttonTheme(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _login() {
    _auth
        .signInWithEmailAndPassword(email: email.text, password: password.text)
        .then((value) {
      authProcess = false;
      notifyListeners();
      print("hasil ${value.user.email}");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HalamanUtama();
      }));
    }).catchError((err) {
      authProcess = false;
      notifyListeners();
      print("hasil error $err");
      _dialog(err.toString());
    });
  }

  _register() {
    _auth
        .createUserWithEmailAndPassword(
            email: email.text, password: password.text)
        .then((value) {
      authProcess = false;
      notifyListeners();
      print("hasil ${value.user.email}");
      userController.userSetup(displayName.text, phoneNumber.text);
      Navigator.pushReplacementNamed(context, "/auth");
    }).catchError((err) {
      authProcess = false;
      notifyListeners();
      print("hasil error $err");
      _dialog(err.toString());
    });
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Email format is incorrect';
    else
      return null;
  }

  String passwordValidator(String value) {
    if (value.length < 6) return "Password minimal 6 character";
    return null;
  }

  String displayNameValidator(String value) {
    Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    ;
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Email format is incorrect';
    else
      return null;
  }

  String phoneNumberValidator(String value) {
    Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Email format is incorrect';
    else
      return null;
  }

  //   Future<void> userSetup() async {
  //   String displayName = "Anonymous", phoneNumber = "";
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   CollectionReference postsRef = Firestore.instance.collection('Users');

  // var documentId = auth.currentUser.uid.toString();

  //   Map<String, dynamic> user = {
  //     "documentId" : documentId,
  //     "displayName": displayName,
  //     "phoneNumber": phoneNumber,
  //   };
  //   await postsRef.doc(documentId).set(user);
  // }

}
