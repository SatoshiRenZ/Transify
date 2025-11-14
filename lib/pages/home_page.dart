import 'package:flutter/material.dart';
import '../template/template.dart';
import '../styles/style.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int currentIndex = 0;

  void onItemTapped(int index) {
  final String? currentRoute = ModalRoute.of(context)?.settings.name;
  String destRoute;
  switch (index) {
    case 0:
      destRoute = '/home';
      break;
    case 1:
      destRoute = '/order';
      break;
    case 2:
      destRoute = '/history';
      break;
    case 3:
      destRoute = '/profile';
      break;
    default:
      return;
  }

  if (currentRoute != destRoute) {
    Navigator.pushReplacementNamed(context, destRoute);
  } else {
    setState(() {
      currentIndex = index; 
    });
  }
}

    @override
    Widget build(BuildContext context) {
      return TemplatePage(
        currentIndex: currentIndex,
        onIndexChanged: onItemTapped,
        child: buildHomeContent(),
      );
    }
  Widget buildHomeContent() {
    return Container(
      // Edit konten halaman di sini
    );
  }
}