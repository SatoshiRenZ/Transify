import 'package:flutter/material.dart';
import '../styles/style.dart';

class ProfileTextField extends StatefulWidget
{
  final String labelText;
  final bool isPassword;
  final TextEditingController? controller;

  const ProfileTextField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    this.controller,
  });

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField>
{
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('${widget.labelText} :', style: AppTextStyles.mainFont15),
        const SizedBox(height: 5),
        TextField(
          controller: widget.controller,
          
          obscureText: widget.isPassword ? !_isPasswordVisible : false,
          
          decoration: InputDecoration(
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
            
            suffixIcon: widget.isPassword
                ? IconButton(
                    padding: const EdgeInsets.only(right: 8.0),
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.mainText,
                    ),
                    onPressed: ()
                    {
                      setState(()
                      {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}