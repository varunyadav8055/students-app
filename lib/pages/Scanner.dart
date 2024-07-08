import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanScreen extends StatefulWidget {
  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  late List<String> rollNos;
  final GlobalKey qrKey = GlobalKey();
  late QRViewController controller;
  Color signal = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR Code'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(color: Colors.red),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.7,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.black, // Use the signal color here
              shape: BoxShape.rectangle,
            ),
            child: Center(
              child: Text(
                "Found",
                style: TextStyle(
                  color: signal, // Set text color to contrast with background
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });

    await studentList(controller);
    controller.scannedDataStream.listen((scanData) async {
      // Handle scanned QR code data
      print('Scanned data: ${scanData.code}');

      // Check the scanned data and change signal color accordingly
      if (rollNos.contains(scanData.code.toString()) || scanData.code == "22b81a05r4") {
        print("found");
      
        setState(() {
          signal = Colors.green;
        });
      } else {
        print("Not found");
          print("$rollNos srollNos");
        setState(() {
          signal = Colors.red;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose(); 
    super.dispose();
  }
  Future<List<String>> studentList(QRViewController controller) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore
        .collection("college_info")
        .where('college_id', isEqualTo: "abc_clg")
        .get();

    if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        print("DocumentSnapshot: $documentSnapshot");

        firestore.collection("college_info").doc(documentSnapshot.id);


List<Map<String, dynamic>> listOfMaps = [];
if ((documentSnapshot.data() as Map<String, dynamic>)['Student_info'] != null) {
  listOfMaps = List<Map<String, dynamic>>.from((documentSnapshot.data() as Map<String, dynamic>)['Student_info'] as List<dynamic>);
}
        rollNos = listOfMaps
    .where((map) => map['Fee'] == true)
    .map((map) => map['Roll_no'].toString())
    .toList();

        print("Roll numbers: $rollNos");

        print("Document updated successfully!");
        // ignore: use_build_context_synchronously
        return rollNos;
    } else {
        print("No document found with college ID:");
    }
    setState(() {
        this.controller = controller;
    });
     return [];
    
}
}
