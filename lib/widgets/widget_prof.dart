import 'package:flutter/material.dart';
import '../styles/profile_style.dart';

class ProfileTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool isPassword;

  const ProfileTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    // Instantiate AppColor to access TextStyles and Colors
    final AppColor style = AppColor();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$labelText :', 
          style: style.mainFontMedium, // Use a defined TextStyle
        ),
        const SizedBox(height: 5),
        TextField(
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            // Custom border color (Orange)
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.primaryOrange, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.primaryOrange, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // Eye icon for the password field
            suffixIcon: isPassword
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.remove_red_eye_outlined, color: AppColor.mainTextColor),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}