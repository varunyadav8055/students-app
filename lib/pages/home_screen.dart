
import 'package:flutter/material.dart';
import 'package:flutter_application_college_app/pages/College_info.dart';
import 'package:flutter_application_college_app/pages/Scanner.dart';
import 'package:flutter_application_college_app/pages/complaints.dart';
import 'package:flutter_application_college_app/reusbale_widgets.dart/info_clg.dart';
import 'package:flutter_application_college_app/reusbale_widgets.dart/shapes.dart';




class home_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Container(
              height: MediaQuery.sizeOf(context).height * 0.35,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(2, 57, 63, 161),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: Color.fromARGB(255, 35, 57, 147),
                      width: MediaQuery.sizeOf(context).width * 0.5,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignInside)),
              child: Text("bus"),
            ),
            SizedBox(height: 10,),
            Text(info_clg.clg_name,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            SingleChildScrollView(
           scrollDirection:  Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Chip(
                        label: Text('Enter the details    '),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the value to change the roundness
                          side:
                              BorderSide(color: Colors.blue), // Optional: Border side
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.05,
                            vertical: MediaQuery.of(context).size.width * 0.18),
                      ),
                      onTap: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => College_info()),
                );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        child: Chip(
                          avatar: Icon(Icons.qr_code_scanner,color: Colors.white),
                          label: Text('QR code Scanner'),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the value to change the roundness
                            side: BorderSide(
                                color: Colors.blue), // Optional: Border side
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.05,
                              vertical: MediaQuery.of(context).size.width * 0.18),
                        ),
                        onTap: () {
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context) => QRScanScreen()));
                        }),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: Chip(
                        label: Text('reciept verifacation'),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Adjust the value to change the roundness
                          side:
                              BorderSide(color: Colors.blue), // Optional: Border side
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.05,
                            vertical: MediaQuery.of(context).size.width * 0.18),
                      ),
                      onTap: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => College_info()),
                );
                      },
                    ),
                  ),
                
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        child: Chip(
                          
                          label: Text('     See Complaints '),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                20.0), // Adjust the value to change the roundness
                            side: BorderSide(
                                color: Colors.blue), // Optional: Border side
                          ),
                          labelStyle: TextStyle(color: Colors.white),
                          padding: EdgeInsets.symmetric(
                              horizontal: MediaQuery.of(context).size.width * 0.05,
                              vertical: MediaQuery.of(context).size.width * 0.18),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Complaints()));
                        }),
                  )
                ],
                            ),
              )
          ],
        ),
      ),
    );
  }
}
