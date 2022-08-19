import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie/controller/Auth_controller.dart';
import 'package:movie/pages/SignUp.dart';
import 'package:movie/utils/mytheme.dart';
import 'package:get/get.dart';
import 'package:movie/utils/social_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
        backgroundColor: MyTheme.splash,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SafeArea(
            child: Container(
              color: Colors.transparent,
              height: _size.height - 100,
              width: _size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/splash_icon.svg"),
                  const Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text("Welcome in Movie booking store",
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                  ),
                  Text(
                    "Login to book your seat, I said its your seat",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      padding: const EdgeInsets.all(19),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: _size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Login to your account",
                            style: TextStyle(
                              fontSize: 16,
                              color: MyTheme.splash,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: TextFormField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Username",
                                hintStyle:
                                    const TextStyle(color: Colors.black45),
                                fillColor: MyTheme.greyColor,
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              style: const TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide.none,
                                ),
                                hintText: "Password",
                                hintStyle:
                                    const TextStyle(color: Colors.black45),
                                fillColor: MyTheme.greyColor,
                                filled: true,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                  title: "Forgort Password?",
                                  content: TextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: forgotEmailController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: "Email address",
                                      hintStyle: const TextStyle(
                                          color: Colors.black45),
                                      fillColor: MyTheme.greyColor,
                                      filled: true,
                                    ),
                                  ),
                                  radius: 10,
                                  onWillPop: () {
                                    forgotEmailController.text = "";

                                    return Future.value(true);
                                  },
                                  // contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  confirm: ElevatedButton(
                                    onPressed: () {
                                      Authcontroller.instance.forgorPassword(
                                          forgotEmailController.text.trim());
                                      forgotEmailController.text = "";
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: MyTheme.splash,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Text(
                                          "Send Reset Mail",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: MyTheme.splash,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                Authcontroller.instance.login(
                                    emailController.text.trim(),
                                    passwordController.text.trim());
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: const Center(
                                    child: Text(
                                  "LOGIN",
                                  style: TextStyle(fontSize: 16),
                                )),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: const Text(
                                    "OR",
                                    style: TextStyle(color: Color(0xFFC1C1C1)),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    thickness: 0.5,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 15),
                            child: SocialLoginButtons(
                              onFbClick: () {},
                              onGoogleClick: () {
                                Authcontroller.instance.googleLogin();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Don't have an account ? ",
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(
                      text: "Sign up ",
                      style: const TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          //Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                          Get.to(() => SignUp());
                        },
                    ),
                    TextSpan(
                        text: "here.",
                        style: TextStyle(fontWeight: FontWeight.w700))
                  ]))
                ],
              ),
            ),
          ),
        ));
  }
}
