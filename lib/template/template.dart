import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/bottom_navbar.dart';
import '../styles/style.dart';

class TemplatePage extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onIndexChanged;
  final Widget child;

  const TemplatePage({
    Key? key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onIndexChanged,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[600],
        backgroundColor: const Color(0xFFFFD700), // Warna kuning keemasan
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}