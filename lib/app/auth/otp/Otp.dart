import 'package:bamis/app/auth/otp/OtpController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  OtpController controller = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Otp Verification"),
          ),
          body: Center(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset( 'assets/ic_dae.png', height: 128 ),
                  const SizedBox(height: 12),
                  const Text("OTP Verification",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(0, 62, 3, 1)
                      )
                  ),
                  const SizedBox(height: 12),
                  Text("Enter the OTP sent to: ${controller.mobile}",
                      style: TextStyle(
                          color: Color.fromRGBO(60, 68, 60, 1)
                      )
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 64,
                            width: 64,
                            child: TextField(
                              controller: controller.otp1,
                              onChanged: (value){ if(value.length == 1) { FocusScope.of(context).nextFocus(); } },
                              style: Theme.of(context).textTheme.headlineSmall,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder()
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 64,
                            width: 64,
                            child: TextField(
                              controller: controller.otp2,
                              onChanged: (value){ if(value.length == 1) { FocusScope.of(context).nextFocus(); } },
                              style: Theme.of(context).textTheme.headlineSmall,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder()
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 64,
                            width: 64,
                            child: TextField(
                              controller: controller.otp3,
                              onChanged: (value){ if(value.length == 1) { FocusScope.of(context).nextFocus(); } },
                              style: Theme.of(context).textTheme.headlineSmall,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder()
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 64,
                            width: 64,
                            child: TextField(
                              controller: controller.otp4,
                              onChanged: (value){ if(value.length == 1) { FocusScope.of(context).nextFocus(); } },
                              style: Theme.of(context).textTheme.headlineSmall,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder()
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(1),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 0),
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
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, top: 0, right: 30, bottom: 0),
                      child: Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(() { return Text("Wait ${controller.second.value} secconds to send new code."); }),
                            Obx(() {
                              if(controller.second == 0) {
                                return InkWell(
                                  onTap: () {
                                    controller.resendOTP();
                                  },
                                  child: Text("RESEND CODE", style: TextStyle(fontWeight: FontWeight.w700)),
                                );
                              }
                              return Text("RESEND CODE");
                            })
                          ],
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
