import 'package:flutter/material.dart';
import '../styles/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
        AppColors.secondary,
      elevation: 0,
      title: Text(
        'Transify',
        style: AppTextStyles.title, 
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}