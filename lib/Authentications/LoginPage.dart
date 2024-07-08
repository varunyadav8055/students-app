// ignore_for_file: unnecessary_import

// ignore: depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_college_app/pages/home_screen.dart';
import 'package:flutter_application_college_app/Authentications/new_member.dart';
import 'package:flutter_application_college_app/reusbale_widgets.dart/info_clg.dart';
import 'package:flutter_application_college_app/reusbale_widgets.dart/shapes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogingPage extends StatefulWidget {
  const LogingPage({super.key});

  @override
  State<LogingPage> createState() => _LogingPageState();
}

class _LogingPageState extends State<LogingPage> {
  @override
  Widget build(BuildContext context) {
    String res = "";
    final TextEditingController emailId = TextEditingController();

    final TextEditingController password = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: const CustomShapeBorder(),
        title: const Text("Bus Managment System"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.groups_sharp,
              size: 100,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                controller: emailId,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the value to change the border radius
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: TextField(
                controller: password,
                obscureText: true,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          20.0), // Adjust the value to change the border radius
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    )),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailId.text, password: password.text)
                      .then((value) {
                    _saveCredentialsToSharedPreferences(
                        emailId.text, password.text);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => home_screen()));
                  }).onError((error, stackTrace) {
                    setState(() {
                      res = "Incorrect Password or User email";
                    });
                  });
                  try {
                    // Query Firestore to check if the college ID already exists
                    QuerySnapshot querySnapshot = await FirebaseFirestore
                        .instance
                        .collection('college_info')
                        .where('college_id', isEqualTo: emailId.text)
                        .get();

                    print(querySnapshot);

                    // If there are no documents returned, the college ID is available
                    {
                      var document = querySnapshot.docs.first;

                      info_clg.clg_buses = document['no_of_buses'];
                      info_clg.clg_name = document['collegeName'];
                      info_clg.clg_id = document['college_id'];
                    }
                  } catch (e) {
                    print("Error in fetching college info");
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.4, 40),
                ),
                child: const Text(
                  "login",
                  style: TextStyle(fontSize: 20),
                )),
            Text(res),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a member?"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const new_member()));
                    },
                    child: const Text(
                      "Register now",
                      style: TextStyle(color: Colors.indigoAccent),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _saveCredentialsToSharedPreferences(
      String email, String password) async {
    print("Saving credentials to shared preferences" + email + password);
    SharedPrefService sharedPrefService = SharedPrefService();

    await sharedPrefService.writeCache(key: 'email', value: email);

    await sharedPrefService.writeCache(key: 'password', value: password);
  }

  Future<String> readCache({required key}) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? value = await pref.getString(key);
    return value!;
  }
}
