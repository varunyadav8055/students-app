import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_college_app/reusbale_widgets.dart/info_clg.dart';

import 'package:flutter_application_college_app/reusbale_widgets.dart/shapes.dart'; // Assuming you have a folder named 'reusable_widgets' with 'shapes.dart' inside

class Complaints extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        shape: const CustomShapeBorder(),
        title: const Text("Bus Management System"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<String>>(
        future: messageList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
          return Container(
  decoration: BoxDecoration(
    color: Colors.white,
  ),
  child: ListView.separated(
    itemCount: snapshot.data!.length,
    itemBuilder: (BuildContext context, int index) {
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            snapshot.data![index][0], // Assuming the data is a string
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          snapshot.data![index],
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      );
    },
    separatorBuilder: (BuildContext context, int index) {
      return Divider();
    },
  ),
);
          }
        },
      ),
    );
  }
}

Future<List<String>> messageList() async {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  QuerySnapshot querySnapshot = await firebaseFirestore
      .collection("college_info")
      .where('college_id', isEqualTo: info_clg.clg_id)
      .get();

  List<String> complaintsList = [];
  if (!querySnapshot.docs.isEmpty) {
    DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
    // Assuming 'complaints' is the name of the field containing the list of complaints
    complaintsList = List<String>.from(documentSnapshot['Complaints'] ?? []);
  }
  return complaintsList;
}
