import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final IconData? icon;
  final Color? iconColor;
  final String? msg;

  const MyTextField({
    Key? key,
    required this.hintText,
    this.obscureText = false,
    required this.controller,
    this.icon,
    this.iconColor,
    this.msg
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      controller: controller,
      obscureText: obscureText,
      validator: (text){
          if(text == null || text.isEmpty){
            return msg;
          }
          return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: iconColor,),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
