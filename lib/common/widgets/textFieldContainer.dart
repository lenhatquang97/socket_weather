import 'package:flutter/material.dart';
typedef StringFunction = String? Function(String?);
class TextFormFieldContainer extends StatelessWidget {
  final TextEditingController controller;
  final StringFunction strValid;
  final bool isObscure;
  const TextFormFieldContainer({required this.strValid,required this.controller,this.isObscure=false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1,color: Colors.black)),
      width: MediaQuery.of(context).size.width / 2,
      child: TextFormField(
        validator: strValid,
        controller: controller,
        style: TextStyle(color: Colors.black),
        obscureText: isObscure,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorStyle: TextStyle(
            color: Colors.black
          )
        ),
      ),
    );
  }
}

