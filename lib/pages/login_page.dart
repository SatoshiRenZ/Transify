import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/style.dart'; 
import '../widgets/widget_prof.dart'; 

class LoginPage extends StatefulWidget
{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _handleLogin() async
  {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString("profile_email", emailController.text); 
    await prefs.setBool("isLoggedIn", true);

    Navigator.pushReplacementNamed(context, '/home'); 
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              Text(
                "Transify",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                  fontFamily: 'Pacifico',
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Log In",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              buildFormCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFormCard(BuildContext context)
  {
    return Card(
      color: AppColors.box,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ProfileTextField(
              labelText: "Email",
              controller: emailController
            ),
            const SizedBox(height: 15),
            ProfileTextField(
              labelText: "Password",
              controller: passwordController,
              isPassword: true
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _handleLogin, 
              child: const Text("Log in", style: TextStyle(color: AppColors.box, fontSize: 16)),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don’t have an account? "),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}