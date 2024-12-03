import 'package:flutter/material.dart';

import 'package:food_ordering_customerapp/services/auth_service.dart';
import 'package:food_ordering_customerapp/services/user_service.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final userServiceInstance = UserService();
  Map<String, dynamic>? userData; // Add this state variable

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userMobileController = TextEditingController();
  final TextEditingController _userAddressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  Future<void> _loadUserDetails() async {
    try {
      final details = await UserService().fetchUserDetails();
      setState(() {
        userData = details;
        _userNameController.text = details['userName'] ?? '';
        _userMobileController.text = details['mobile'] ?? '';
        _userAddressController.text = details['address'] ?? '';
      });
    } catch (e) {
      print('Error loading user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 150,
                  width: 150,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: Image.asset("lib/assets/images/user.jpg")),
              TextField(
                controller: _userNameController,
                decoration: const InputDecoration(label: Text("User Name")),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _userMobileController,
                  decoration:
                      const InputDecoration(label: Text("Phone Number"))),
              SizedBox(
                height: 20,
              ),
              TextField(
                  controller: _userAddressController,
                  decoration: const InputDecoration(label: Text("Address"))),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 255, 137, 2))),
                  onPressed: () async {
                    await userServiceInstance.createUser(
                        context,
                        _userNameController.text,
                        _userMobileController.text,
                        _userAddressController.text);
                  },
                  child: const Text("save")),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red)),
                  onPressed: () {
                    AuthService().userSignout(context);
                  },
                  child: const Text("SignOut")),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _userMobileController.dispose();
    _userAddressController.dispose();
    super.dispose();
  }
}
