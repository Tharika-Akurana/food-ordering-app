import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/services/auth_service.dart';


class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              const Text(
                "Reset Password",
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _emailController,
                style:
                    const TextStyle(color: Color.fromARGB(255, 126, 126, 126)),
                decoration: const InputDecoration(
                    label: Text("Enter your email"),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 126, 191, 244))),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              TextButton(
                  onPressed: () async {
                    await _auth.sendresetPasswordLink(_emailController.text);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: const Text(
                            "A password reset link has sent to your email address! ")));
                    Navigator.pop(context);
                  },
                  child: const Text("Send verification code")),
            ],
          ),
        ),
      ),
    );
  }
}
