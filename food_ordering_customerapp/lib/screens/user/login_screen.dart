import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_ordering_customerapp/screens/user/forgot_password_screen.dart';
import 'package:food_ordering_customerapp/screens/user/signup_screen.dart';
import 'package:food_ordering_customerapp/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isloading = false;

//dispose method implements to remove unnecesary storeges and increase performance
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Login",
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
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 126, 191, 244))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)))),
                  const SizedBox(
                    height: 70,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await _auth.loginUserWithEmailAndPassword(context,
                            _emailController.text, _passwordController.text);

                        //     _emailController.text, _passwordController.text);
                        //Navigation to the home screen is unnecessary when wrapper handles the signin function
                        // if(user != null){
                        //   Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => HomeScreen()));
                        // }
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                              const Color.fromARGB(255, 255, 132, 0))),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  isloading
                      ? const CircularProgressIndicator()
                      : IconButton(
                          onPressed: () async {
                            setState(() {
                              isloading = true;
                            });
                            final userCred = await _auth.loginWithGoogle();
                            log("*************************************************************************${userCred?.user?.displayName}*****************************************************");
                            setState(() {
                              isloading = false;
                            });
                          },
                          icon: Image.asset(
                            "lib/assets/images/google.png",
                            height: 40,
                          )),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()));
                      },
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 126, 196, 252)),
                      )),
                  Row(
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupScreen()));
                          },
                          child: const Text(
                            "Register",
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
        ),
      ),
    );
  }
}
