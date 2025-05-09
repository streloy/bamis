import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../register/Register.dart';
import 'LoginController.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
          child: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset( 'assets/ic_dae.png', height: 128 ),
                  const SizedBox(height: 12),
                  const Text("Login",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 62, 3, 1)
                      )
                  ),
                  const SizedBox(height: 12),
                  const Text("Please Enter The mobile no and password to login",
                      style: TextStyle(
                          color: Color.fromRGBO(60, 68, 60, 1)
                      )
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controller.email,
                    decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        label: Text("Enter Email/Mobile No"),
                        border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: controller.password,
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      label: Text("Password"),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  const SizedBox(
                    width: double.infinity,
                    child: Text("Forget password?",
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(60, 68, 60, 1)
                        )
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.loginClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF004A03),
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text("Login", style: TextStyle(color: Colors.amber, fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const SizedBox(
                    width: double.infinity,
                    child: Text("------  Connect Using  ------", textAlign: TextAlign.center),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/fb.png', height: 56),
                      SizedBox(width: 12),
                      Image.asset('assets/google.png', height: 56),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don’t have an account?"),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          Get.offAll(Register(), transition: Transition.rightToLeft);
                        },
                        child: const Text("Register", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF28A745))),
                      ),
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
