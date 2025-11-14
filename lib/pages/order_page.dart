import 'package:flutter/material.dart';
import '../template/template.dart';
import '../styles/style.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);
  @override
  OrderPageState createState() => OrderPageState();
}

class OrderPageState extends State<OrderPage> {
  int currentIndex = 1; 

  void onItemTapped(int index) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    String destinationRoute;
    switch (index) {
      case 0:
        destinationRoute = '/home';
        break;
      case 1:
        destinationRoute = '/order';
        break;
      case 2:
        destinationRoute = '/history';
        break;
      case 3:
        destinationRoute = '/profile';
        break;
      default: return;
    }
    if (currentRoute != destinationRoute) {
      Navigator.pushReplacementNamed(context, destinationRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TemplatePage(
      currentIndex: currentIndex,
      onIndexChanged: onItemTapped,
      child: buildOrderContent(),
    );
  }

  Widget buildOrderContent() {
    return const Center(
      // Edit konten halaman di sini
    );
  }
}