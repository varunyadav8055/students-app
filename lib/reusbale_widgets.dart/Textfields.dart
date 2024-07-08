import 'package:flutter/material.dart';

TextField reusing_textfield(TextEditingController cts,bool obscure,String hint_text,IconData icon){
  return  TextField(
              controller: cts,
              obscureText: obscure,
              decoration: InputDecoration(
                filled: true,
                prefix: Text("  "),
                fillColor: Colors.white,
                hintText: hint_text,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                 
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0), // Adjust the vertical padding
              
                  prefixIcon: Icon(icon)
                ),
              
            );
}