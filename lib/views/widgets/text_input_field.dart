// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flick_clips/constants.dart';

class TextInputField extends StatelessWidget {
  
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isObscure;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
     this.isObscure=false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 20),
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: borderColor,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: borderColor,),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
