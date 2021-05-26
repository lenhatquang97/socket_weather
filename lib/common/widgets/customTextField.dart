import 'package:flutter/material.dart';
typedef StringFunction = String? Function(String?);
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final StringFunction strValid;
  final String hintText;
  const CustomTextField({required this.hintText,required this.strValid,required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10,bottom: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1,color: Colors.black)),
      //Some changes
      height: 40,
      width: MediaQuery.of(context).size.width / 2,
      child: TextFormField(
        validator: strValid,
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.black),
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
