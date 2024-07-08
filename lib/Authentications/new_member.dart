// ignore: depend_on_referenced_packages';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:flutter_application_college_app/Authentications/LoginPage.dart';

import 'package:flutter_application_college_app/reusbale_widgets.dart/Textfields.dart';
import '../reusbale_widgets.dart/shapes.dart';

// ignore: camel_case_types
class new_member extends StatefulWidget {
  const new_member({super.key});

  @override
  State<new_member> createState() => _new_memberState();
}

// ignore: camel_case_types
class _new_memberState extends State<new_member> {
  // ignore: non_constant_identifier_names
  TextEditingController clgIdController = TextEditingController();
  String message = '';
  bool perfect_id = false;
  @override
  void initState() {
    super.initState();
    clgIdController.addListener(_checkCollegeIdAvailability);
  }

  @override
  void dispose() {
    clgIdController.removeListener(_checkCollegeIdAvailability);
    clgIdController.dispose();
    super.dispose();
  }

  TextEditingController email_id = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController password_check = TextEditingController();
  Color report_clr = Colors.red;
  Color val_clr = Colors.red;
  String report = "Password must be same";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: const CustomShapeBorder(),
        title: const Text("New Registration"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            reusing_textfield(email_id, false, "email_id", Icons.email),
            const SizedBox(
              height: 15,
            ),
            reusing_textfield(clgIdController, false, "college ID",
                Icons.account_balance_rounded),
            const SizedBox(
              height: 15,
            ),
            Text(message),
            const SizedBox(
              height: 15,
            ),
            reusing_textfield(
                password, false, "Enter the password", Icons.email),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                "enter 8 sized password,with character @# and Capital letter",
                style: TextStyle(fontSize: 10, color: val_clr),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            reusing_textfield(
                password_check, false, "Confirm the password", Icons.email),
            const SizedBox(
              height: 5,
            ),
            Text(
              report,
              style: TextStyle(
                fontSize: 10,
                color: report_clr,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (validatePassword(password.text)) {
                  setState(() {
                    val_clr =
                        Colors.green; // Change color when password is valid
                  });
                }

                // Check password equality
                if (checkPasswords(password.text, password_check.text)) {
                  setState(() {
                    report_clr =
                        Colors.green; // Change color when passwords match
                  });
                  if (perfect_id) {
                    FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: email_id.text, password: password_check.text);
                    CollectionReference ref =
                        FirebaseFirestore.instance.collection("college_info");

                    ref.add({
                      'college_id': clgIdController.text,
                      'email': email_id.text,
                      'no_of_buses': null, // Replace Null with null
                      'upi_id': null, // Replace Null with null
                      'bus_fee':null
                    }).then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LogingPage()),
                        ));
                  } else {
                    setState(() {
                      report_clr = Colors.red;
                      report = "Passwords must be the same";
                    });
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(
                    200,
                    50,
                  ),
                  backgroundColor: Colors.blue),
              child: const Text(
                "SUMBIT",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool checkPasswords(String pass1, String pass2) {
    return pass1 == pass2;
  }

  bool validatePassword(String password) {
    print("inside the validate fun");
    // Check the length of the password
    if (password.length < 8) {
      return false; // Password length is less than 8 characters
    }

    // Check if the password contains at least one special character (@ or #)
    if (!password.contains(RegExp(r'[#@]'))) {
      return false; // Password does not contain @ or #
    }

    // Check if the password contains at least one capital letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false; // Password does not contain a capital letter
    }

    // If all conditions are met, return true
    return true;
  }

  void _checkCollegeIdAvailability() async {
    String collegeId = clgIdController.text;

    if (collegeId.isEmpty) {
      setState(() {
        message = ''; // Clear message when ID is empty
      });
      return;
    }

    try {
      // Query Firestore to check if the college ID already exists
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('college_info')
          .where('college_id', isEqualTo: collegeId)
          .get();

      // If there are no documents returned, the college ID is available
      if (querySnapshot.docs.isEmpty) {
        setState(() {
          message = 'College ID is available!';
          perfect_id = true;
        });
      } else {
        setState(() {
          message = 'College ID is already in use.';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error checking college ID: $e';
      });
    }
  }
}
// ignore: non_constant_identifier_names
