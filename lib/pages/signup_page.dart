import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../styles/style.dart';
import '../widgets/widget_prof.dart';

class SignupPage extends StatefulWidget
{
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>
{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  Future<void> _handleSignup() async
  {
    final prefs = await SharedPreferences.getInstance();
    
    if (passwordController.text != confirmController.text)
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }
    
    await prefs.setString("profile_name", nameController.text);
    await prefs.setString("profile_email", emailController.text);
    
    await prefs.setBool("isLoggedIn", true);

    Navigator.pushReplacementNamed(context, '/login'); 
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
                "Sign Up",
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
              labelText: "Name",
              controller: nameController,
            ),
            const SizedBox(height: 15),
            ProfileTextField(
              labelText: "Email",
              controller: emailController,
            ),
            const SizedBox(height: 15),
            ProfileTextField(
              labelText: "Password",
              controller: passwordController,
              isPassword: true
            ),
            const SizedBox(height: 15),
            ProfileTextField(
              labelText: "Confirm Password",
              controller: confirmController,
              isPassword: true
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _handleSignup,
              child: const Text("Sign up", style: TextStyle(color: AppColors.box, fontSize: 16)),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/login'),
                  child: const Text(
                    "Log in",
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

  Widget buildTextField(String label, String hint, TextEditingController controller,
      {bool obscure = false})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.mainFont15.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}