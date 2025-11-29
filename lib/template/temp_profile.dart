import 'package:flutter/material.dart';
import '../styles/profile_style.dart'; 

class AppTemplate extends StatelessWidget {
  final Widget bodyWidget;

  const AppTemplate({
    super.key,
    required this.bodyWidget,
  });

  // Helper method for the Top Header (Transify)
  Widget _buildAppHeader() {
    final AppColor style = AppColor();
    
    return Container(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      color: AppColor.appBarYellow,
      width: double.infinity,
      child: Center(
        child: Text(
          'Transify',
          style: style.appBarTitle.copyWith(fontSize: 28), // Use your defined AppBar style
        ),
      ),
    );
  }

  // Helper method for the Bottom Navigation Bar
  Widget _buildBottomNavBar() {
    return Container(
      color: AppColor.appBarYellow,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Home, Order, History icons (assuming they are inactive/black)
          Icon(Icons.home, size: 30, color: AppColor.mainTextColor),
          Icon(Icons.airplane_ticket, size: 30, color: AppColor.mainTextColor),
          Icon(Icons.access_time, size: 30, color: AppColor.mainTextColor),
          // Highlighted profile icon (Active/Orange)
          Icon(Icons.person, size: 30, color: AppColor.primaryOrange), 
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundYellow,
      body: Column(
        children: <Widget>[
          // 1. Header 
          _buildAppHeader(),
          
          // 2. Main Content (Passed in by the page)
          Expanded(
            child: bodyWidget,
          ),
          
          // 3. Bottom Navigation Bar
          _buildBottomNavBar(),
        ],
      ),
    );
  }
}