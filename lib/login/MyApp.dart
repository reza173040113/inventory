import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inventory/HalamanUtama.dart';
import 'Login.dart';
import 'AppTheme.dart';
import 'AuthView.dart';
import 'HomewView.dart';
import 'WelcomeView.dart';

class MyApp extends StatelessWidget {
  final AppTheme _theme = new AppTheme();
  final routes = {
    "/welcome": (_) => WelcomeView(),
    "/auth": (_) => AuthView(),
    "/login": (_) => LoginView(),
    "/home": (_) => HalamanUtama(),
    // "/admin": (_) => AdminAspirasi(),
  };

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      title: 'INVENTORIES',
      theme: ThemeData(
        primarySwatch: _theme.appColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: auth.currentUser == null ? "/welcome" : "/home",
    );
  }
}

class CheckUser extends StatefulWidget {
  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (c, i) => Container(
          child: Row(
            children: [FlutterLogo(), Text("Data ke-$i")],
          ),
        ),
        itemCount: 4000,
      ),
    );
  }
}
