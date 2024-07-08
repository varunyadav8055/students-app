// ignore: file_names
// ignore_for_file: non_constant_identifier_names



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_college_app/pages/home_screen.dart';
import 'package:flutter_application_college_app/reusbale_widgets.dart/Textfields.dart';

class College_info extends StatefulWidget {
  College_info({Key? key}) : super(key: key);

  @override
  State<College_info> createState() => _College_infoState();
}

class _College_infoState extends State<College_info> {
  TextEditingController no_of_buses = TextEditingController();
  TextEditingController clg_id = TextEditingController();
  TextEditingController upi_id = TextEditingController();
  TextEditingController bus_fee = TextEditingController();
  TextEditingController clg_mail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 192, 186, 186),
      appBar: AppBar(
        title: const Text("College information"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 85,
                backgroundImage: NetworkImage(
                    'https://i.pinimg.com/736x/54/72/d1/5472d1b09d3d724228109d381d617326.jpg'),
              ),
              IconButton(
  onPressed: () {
    // Add functionality to open camera here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening Camera...'),
      ),
    );
  }, 
  icon: Icon(Icons.camera_alt),
)
,
              reusing_textfield(
                  clg_id, false, "College ID", Icons.admin_panel_settings),
              const SizedBox(
                height: 10,
              ),
              // mail id
              reusing_textfield(clg_mail, false, "College Mail", Icons.mail),
              const SizedBox(
                height: 10,
              ),
              reusing_textfield(
                  no_of_buses, false, "NO of buses", Icons.bus_alert),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: bus_fee,
                decoration: InputDecoration(
                  hintText: 'Enter the bus fee',
                  prefixIcon: const Icon(Icons.money),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 20,
              ),
              reusing_textfield(upi_id, false, "UPI ID", Icons.payment),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (clg_id.text.isEmpty ||
                      no_of_buses.text.isEmpty ||
                      upi_id.text.isEmpty ||
                      bus_fee.text.isEmpty ||
                      clg_mail.text.isEmpty) {
                    SnackBar(
                      content: const Text("Please fill all the fields"),
                    );
                  }
                  if (upi_id.text.length < 10) {
                    SnackBar(
                      content: const Text("Please enter valid UPI ID"),
                    );
                    
                  }
                  FirebaseFirestore firestore = FirebaseFirestore.instance;

                  QuerySnapshot querySnapshot = await firestore
                      .collection("college_info")
                      .where('college_id', isEqualTo: clg_id.text)
                      .get();

                  print("QuerySnapshot: $querySnapshot");

                  if (querySnapshot.docs.isNotEmpty) {
                    DocumentSnapshot documentSnapshot =
                        querySnapshot.docs.first;
                    print("DocumentSnapshot: $documentSnapshot");

                    DocumentReference documentRef = firestore
                        .collection("college_info")
                        .doc(documentSnapshot.id);

                    Map<String, dynamic> dataToUpdate = {
                      'no_of_buses': no_of_buses.text,
                      'upi_id': upi_id.text,
                      'bus_fee': int.parse(bus_fee.text),
                      'clg_mail': clg_mail.text
                      // Add other fields here
                    };

                    print("Data to update: $dataToUpdate");

                    await documentRef.update(dataToUpdate);
                    print("Document updated successfully!");
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Succesfully updated the changes...'),
      ),
    );
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => home_screen()));
                  } 
                  else {
                    print("No document found with college ID: ${clg_id.text}");
                  }
                },
                child: const Text("SUBMIT"),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
}
