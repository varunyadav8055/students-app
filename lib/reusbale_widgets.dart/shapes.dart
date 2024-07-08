import 'package:flutter/material.dart';

class CustomShapeBorder extends ContinuousRectangleBorder {
  const CustomShapeBorder();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final path = Path();
    path.lineTo(0, rect.height);
    path.quadraticBezierTo(
        rect.width / 2, rect.height + 30, rect.width, rect.height);
    path.lineTo(rect.width, 0);
    path.close();
    return path;
  }


   Widget portfolio(BuildContext context, VoidCallback onTap,String Label) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: onTap,
      child: Chip(
        avatar: Icon(Icons.qr_code_scanner, color: Colors.white),
        label: Text(Label),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Colors.blue),
        ),
        labelStyle: TextStyle(color: Colors.white),
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.width * 0.18,
        ),
      ),
    ),
  );
}

}