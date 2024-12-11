import 'package:bamis/app/auth/mobile/MobileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Mobile extends StatefulWidget {
  const Mobile({super.key});

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {

  MobileController controller = Get.put(MobileController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(

        child: Scaffold(
          body: Center(
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
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 0),
                    child: TextField(
                      controller: controller.mobile,
                      decoration: InputDecoration(
                          hintText: "01---------",
                          label: Text("Enter Mobile No"),
                          border: OutlineInputBorder()
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 0),
                      child: ElevatedButton(
                        onPressed: controller.gotoOTP,
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
                  ),
                  // const SizedBox(height: 16),
                  // const SizedBox(
                  //   width: double.infinity,
                  //   child: Text("------  Connect Using  ------", textAlign: TextAlign.center),
                  // ),
                  // const SizedBox(height: 16),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Image.asset('assets/fb.png', height: 56),
                  //     SizedBox(width: 12),
                  //     Image.asset('assets/google.png', height: 56),
                  //   ],
                  // ),
                  const SizedBox(height: 16),
                  const Text("Powered by RIMES",
                      style: TextStyle(
                          color: Color.fromRGBO(60, 68, 60, 1)
                      )
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
