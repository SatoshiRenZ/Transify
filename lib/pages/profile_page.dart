import 'package:flutter/material.dart';
import '../styles/profile_style.dart'; 
import '../widgets/widget_prof.dart';
import '../template/temp_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Widget Builder for the content that goes inside the AppTemplate
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
        // Orange Circle Avatar
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
              'user.123@gmail.com', 
              style: style.mainFontMedium.copyWith(color: AppColor.mainTextColor.withOpacity(0.6)) // Use a slightly subdued color
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
          // Title: Edit Profile
          Text('Edit Profile', style: style.mainFontMedium.copyWith(fontWeight: FontWeight.bold)),
          Divider(color: AppColor.mainTextColor.withOpacity(0.5)),
          const SizedBox(height: 10),

          // Text Fields 
          const ProfileTextField(labelText: 'Name', hintText: 'Full name'),
          const SizedBox(height: 20),
          const ProfileTextField(labelText: 'Password', hintText: '********', isPassword: true),
          const SizedBox(height: 20),
          const ProfileTextField(labelText: 'Email', hintText: 'example.email@gmail.com'),
          const SizedBox(height: 20),

          // Links
          GestureDetector(
            onTap: () { /* Handle Logout */ },
            child: Text(
              'Logout', 
              style: style.mainFontMedium.copyWith(color: AppColor.primaryOrange, decoration: TextDecoration.underline)
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () { /* Handle Delete Account */ },
            child: Text(
              'Delete Account', 
              style: style.mainFontMedium.copyWith(color: AppColor.primaryOrange, decoration: TextDecoration.underline)
            ),
          ),
          const SizedBox(height: 30),

          // Edit Profile Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () { /* Handle profile update */ },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryOrange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Edit Profile', 
                style: style.mainFontMedium.copyWith(color: AppColor.mainTextColor, fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Wrap the page content with the AppTemplate
    return AppTemplate(
      bodyWidget: _buildPageContent(),
    );
  }
}