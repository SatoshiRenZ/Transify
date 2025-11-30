import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'pages/homepage/home_page.dart';
import 'pages/order_page.dart';
//import 'pages/history_page.dart';
//import 'pages/profile_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import '../styles/style.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);
  await GoogleFonts.pendingFonts([
    GoogleFonts.irishGrover(),
    GoogleFonts.sulphurPoint(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transify',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.primary,
      ),
            
      initialRoute: '/home',
      routes: {
        '/login':
          (context) =>
            const LoginPage(),
        '/signup':
          (context) =>
            const SignupPage(),
        '/home': 
          (context) => 
            const HomePage(),
        '/order':
          (context) =>
            const OrderPage(),
        // '/history':
        //   (context) =>
        //     const HistoryPage(),
        // '/profile':
        //   (context) =>
        //     const ProfilePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}