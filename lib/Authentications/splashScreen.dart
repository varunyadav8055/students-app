import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_college_app/Authentications/LoginPage.dart';
import 'package:flutter_application_college_app/pages/home_screen.dart';
import 'package:flutter_application_college_app/reusbale_widgets.dart/info_clg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _attemptAutoLogin();
  }

  Future<String> readCache({required String key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? value = pref.getString(key);
    return value ?? '';
  }

  void _attemptAutoLogin() async {
    String email = await readCache(key: 'email');

    String password = await readCache(key: 'password');

    if (email.isEmpty || password.isEmpty) {
      print("No email or password found");
      _navigateToPage(LogingPage());
    } else {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('college_info')
          .where('clg_mail', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var document = querySnapshot.docs.first;
        // Continue processing the document
        info_clg.clg_buses = int.parse(document['no_of_buses']);
      info_clg.clg_name = document['collegeName'];
      info_clg.clg_id = document['college_id'];

      print("Email and password found");
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        _navigateToPage(home_screen());
      } catch (e) {
        print("error in logining");
        // Handle error, e.g. show a message to the user
        _navigateToPage(LogingPage());
      }
      } else {
        print('No documents found');
      }
      
      
    }
  }

  void _navigateToPage(Widget page) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/bus.png'),
            Text(
              'Bus Managment System',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
            SpinKitFadingCube(
              color: Colors.blue,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
