
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_college_app/Authentications/LoginPage.dart';

import 'package:flutter_application_college_app/Authentications/splashScreen.dart';




// Assuming this file contains your Firebase configuration options

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(); // options: DefaultFirebaseConfig.platformOptions
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
     const FirebaseOptions(
    apiKey: 'AIzaSyB4blhdkghoy012doNdiY0Kz2n13dy3x6Qvarun8055',
    appId: '1:506177492125:android:c99d1e274e7eaf96ce7074',
    messagingSenderId: '506177492125',
    projectId: 'collegedatabase-e91cd',
    databaseURL: 'xxxxxxxxxxxxxxxxxxx',
    storageBucket: 'collegedatabase-e91cd.appspot.com',
    ),
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:SplashScreen(), 
    );
  }
}
