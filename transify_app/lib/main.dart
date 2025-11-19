import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';

void main() {
  runApp(const TransifyApp());
}

class TransifyApp extends StatelessWidget {
  const TransifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transify',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFFBE7B2),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
      },
    );
  }
}
