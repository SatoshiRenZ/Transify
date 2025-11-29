import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styles/profile_style.dart'; 
import '../template/temp_profile.dart';
import '../widgets/profiletextfield.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Text Controllers for storage
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedProfile();
  }

  Future<void> _loadSavedProfile() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      nameController.text = prefs.getString("profile_name") ?? "";
      passwordController.text = prefs.getString("profile_password") ?? "";
      emailController.text = prefs.getString("profile_email") ?? "";
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("profile_name", nameController.text);
    await prefs.setString("profile_password", passwordController.text);
    await prefs.setString("profile_email", emailController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile saved locally")),
    );
  }

  // Your existing builder
  Widget _buildPageContent() {
    final AppColor style = AppColor();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          _buildUserHeader(style),
          const SizedBox(height: 30),
          _buildProfileCard(style),
        ],
      ),
    );
  }

  Widget _buildUserHeader(AppColor style) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const CircleAvatar(
          radius: 30,
          backgroundColor: AppColor.primaryOrange,
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('User', style: style.mainFontLarge.copyWith(fontSize: 22)),
            Text(
              emailController.text.isEmpty
                  ? 'user.123@gmail.com'
                  : emailController.text,
              style: style.mainFontMedium.copyWith(
                color: AppColor.mainTextColor.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileCard(AppColor style) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColor.backgroundYellow,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColor.mainTextColor.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Edit Profile',
              style: style.mainFontMedium.copyWith(fontWeight: FontWeight.bold)),
          Divider(color: AppColor.mainTextColor.withOpacity(0.5)),
          const SizedBox(height: 10),

          // Inject controllers
          ProfileTextField(
            labelText: 'Name',
            hintText: 'Full name',
            controller: nameController,
          ),
          const SizedBox(height: 20),

          ProfileTextField(
            labelText: 'Password',
            hintText: '********',
            isPassword: true,
            controller: passwordController,
          ),
          const SizedBox(height: 20),

          ProfileTextField(
            labelText: 'Email',
            hintText: 'example.email@gmail.com',
            controller: emailController,
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: () {},
            child: Text(
              'Logout',
              style: style.mainFontMedium.copyWith(
                color: AppColor.primaryOrange,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 10),

          GestureDetector(
            onTap: () {},
            child: Text(
              'Delete Account',
              style: style.mainFontMedium.copyWith(
                color: AppColor.primaryOrange,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saveProfile, // Save button
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryOrange,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Edit Profile',
                style: style.mainFontMedium.copyWith(
                  color: AppColor.mainTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppTemplate(
      bodyWidget: _buildPageContent(),
    );
  }
}
