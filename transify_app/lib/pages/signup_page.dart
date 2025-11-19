import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: buildBottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              const Text(
                "Transify",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
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

  Widget buildFormCard(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildTextField("Name :", "Full name", nameController),
            const SizedBox(height: 15),
            buildTextField("Email :", "example.email@gmail.com", emailController),
            const SizedBox(height: 15),
            buildTextField("Password :", "********", passwordController, obscure: true),
            const SizedBox(height: 15),
            buildTextField("Confirm Password :", "********", confirmController, obscure: true),
            const SizedBox(height: 25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                minimumSize: const Size(double.infinity, 45),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () => Navigator.pushNamed(context, '/login'),
              child: const Text("Sign up", style: TextStyle(color: Colors.white, fontSize: 16)),
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
                    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
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
      {bool obscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
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

  Widget buildBottomBar() {
    return Container(
      height: 60,
      color: Colors.orange,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.message, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],
      ),
    );
  }
}