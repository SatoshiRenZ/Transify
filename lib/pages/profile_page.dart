import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styles/style.dart';
import '../widgets/widget_prof.dart';
import '../template/template.dart';

class ProfilePage extends StatefulWidget
{
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState()
  {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async
  {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool("isLoggedIn") ?? false;

    if (!isLoggedIn)
    {
      if (mounted)
      {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      }
    }
    else
    {
      await _loadSavedProfile(prefs);
      if (mounted)
      {
        setState(()
        {
          _isLoggedIn = true;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _loadSavedProfile(SharedPreferences prefs) async
  {
    setState(()
    {
      nameController.text = prefs.getString("profile_name") ?? "";
      passwordController.text = prefs.getString("profile_password") ?? "";
      emailController.text = prefs.getString("profile_email") ?? "";
    });
  }

  Future<void> _saveProfile() async
  {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("profile_name", nameController.text);
    await prefs.setString("profile_password", passwordController.text);
    await prefs.setString("profile_email", emailController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Profile saved!",
          style: AppTextStyles.mainFont15.copyWith(color: AppColors.box),
        ),
        backgroundColor: AppColors.secondary,
      ),
    );
  }
  
  Future<void> _handleLogout() async
  {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", false); 

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Future<void> _handleDeleteAccount() async
  {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.clear();
    
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account successfully deleted. You have been logged out.")),
    );

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  Widget _buildPageContent()
  {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          _buildUserHeader(),
          const SizedBox(height: 30),
          _buildProfileCard(),
        ],
      ),
    );
  }

  Widget _buildUserHeader()
  {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.secondary,
          child: Icon(Icons.person, size: 35, color: AppColors.mainText),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              nameController.text.isEmpty ? 'User' : nameController.text,
              style: AppTextStyles.mainFont25.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              emailController.text.isEmpty
                  ? 'user.123@gmail.com'
                  : emailController.text,
              style: AppTextStyles.mainFont15.copyWith(
                color: AppColors.mainText,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileCard()
  {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.box,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainText,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Edit Profile',
            style: AppTextStyles.mainFont20.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: AppColors.mainText),
          const SizedBox(height: 10),

          ProfileTextField(
            labelText: 'Name',
            controller: nameController,
          ),
          const SizedBox(height: 20),

          ProfileTextField(
            labelText: 'Password',
            isPassword: true,
            controller: passwordController,
          ),
          const SizedBox(height: 20),

          ProfileTextField(
            labelText: 'Email',
            controller: emailController,
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: _handleLogout,
            child: Text(
              'Logout',
              style: AppTextStyles.mainFont15.copyWith(
                color: AppColors.hover,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),

          GestureDetector(
            onTap: _handleDeleteAccount,
            child: Text(
              'Delete Account',
              style: AppTextStyles.mainFont15.copyWith(
                color: Colors.red,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Save Profile',
                style: AppTextStyles.mainFont15.copyWith(
                  color: AppColors.mainText,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onItemTapped(int index)
  {
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
      default:
        return;
    }
    if (currentRoute != destinationRoute)
    {
      Navigator.pushReplacementNamed(context, destinationRoute);
    }
  }

  @override
  Widget build(BuildContext context)
  {
    if (_isLoading)
    {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: AppColors.secondary)), 
      );
    }
    
    return TemplatePage(
      currentIndex: 3,
      onIndexChanged: onItemTapped,
      child: SafeArea(child: _buildPageContent()),
    );
  }
}