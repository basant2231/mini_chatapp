import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  String textt;
  void Function(String)? onChanged;
  bool ispass;
  MyTextField({
    Key? key,
    required this.textt,
    required this.onChanged,
    required this.ispass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(obscureText: ispass,
    keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: textt,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(225, 206, 53, 130), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan[600]!, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
