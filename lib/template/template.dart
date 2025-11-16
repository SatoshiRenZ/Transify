import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_navbar.dart';
import '../styles/style.dart';

class TemplatePage extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  final ValueChanged<int>? onIndexChanged;
  final bool showAppBar;
  final bool showBottomNav;
  
  const TemplatePage({
    Key? key,
    required this.child,
    this.currentIndex = 0,
    this.onIndexChanged,
    this.showAppBar = true,
    this.showBottomNav = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
        AppColors.primary,
      appBar: 
        showAppBar
          ? const CustomAppBar()
          : null,
      body:
        child,
          bottomNavigationBar: showBottomNav && onIndexChanged != null ? CustomBottomNavBar(
            currentIndex: currentIndex,
            onTap: onIndexChanged!,
          ) : null,
    );
  }
}