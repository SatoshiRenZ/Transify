import 'package:flutter/material.dart';
import '../styles/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
        secondaryColor,
      elevation: 0,
      title: Text(
        'Transify',
        style: appBarTitle, 
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}