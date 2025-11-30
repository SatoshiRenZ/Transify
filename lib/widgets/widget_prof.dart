import 'package:flutter/material.dart';
import '../styles/style.dart';

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
      children: <Widget>[
        Text('$labelText :', style: AppTextStyles.mainFont15),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.mainFont12.copyWith(
              color: AppColors.mainText.withOpacity(0.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.secondary,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.hover, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            suffixIcon: isPassword
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColors.mainText,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
