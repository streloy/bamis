import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login/Login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                  const Text("Sign up",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 62, 3, 1)
                      )
                  ),
                  const SizedBox(height: 12),
                  const Text("Please Enter The mobile no or Email to for getting OTP ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(60, 68, 60, 1)
                      )
                  ),
                  const SizedBox(height: 24),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: "example@gmail.com",
                        label: Text("Enter Email/Mobile No"),
                        border: OutlineInputBorder()
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF004A03),
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text("Request OTP", style: TextStyle(color: Colors.amber, fontSize: 16)),
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
                      Text("Already have account?"),
                      SizedBox(width: 12),
                      InkWell(
                          onTap: () {
                            Get.offAll(Login(), transition: Transition.leftToRight);
                          },
                          child: Text("Login", style: TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF28A745)))
                      )
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
