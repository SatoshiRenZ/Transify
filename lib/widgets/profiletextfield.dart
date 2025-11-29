import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;

  const ProfileTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
    this.controller,   
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        const SizedBox(height: 5),
        TextField(
          controller: controller,   
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
