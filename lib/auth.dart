import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/style.dart';

class AuthCheckPage extends StatefulWidget
{
  const AuthCheckPage({super.key});

  @override
  State<AuthCheckPage> createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage>
{
  @override
  void initState()
  {
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async
  {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool("isLoggedIn") ?? false; 

    await Future.delayed(const Duration(milliseconds: 500)); 

    if (!mounted) return;

    if (isLoggedIn)
    {
      Navigator.pushReplacementNamed(context, '/home');
    }
    else
    {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.secondary, 
        ), 
      ),
    );
  }
}