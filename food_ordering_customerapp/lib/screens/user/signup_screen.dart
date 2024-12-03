import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/Wrapper.dart';
import 'package:food_ordering_customerapp/screens/user/login_screen.dart';
import 'package:food_ordering_customerapp/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

//dispose method implements to remove unnecesary storages and increase performance
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Register",
                style: TextStyle(fontSize: 25, color: Colors.blue),
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                  controller: _emailController,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 126, 126, 126)),
                  decoration: const InputDecoration(
                      label: Text("email"),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 244, 126, 126))),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)))),
              const SizedBox(
                height: 20,
              ),
              TextField(
                  obscureText: true,
                  controller: _passwordController,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 126, 126, 126)),
                  decoration: const InputDecoration(
                      label: Text("password"),
                      border: UnderlineInputBorder(borderSide: BorderSide()),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue)))),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          const Color.fromARGB(255, 255, 137, 2))),
                  onPressed: () async {
                    final user = await _auth.createUserWithEmailAndPassword(
                        context,
                        _emailController.text,
                        _passwordController.text);
                    if (user != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Wrapper()));
                    }
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text(
                        "login",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 126, 196, 252)),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
