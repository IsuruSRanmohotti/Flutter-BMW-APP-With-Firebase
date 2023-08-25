import 'package:ce_store/providers/signin_provider.dart';
import 'package:ce_store/screens/auth/forgot_password.dart';
import 'package:ce_store/screens/auth/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_buttons/custom_button1.dart';
import '../../components/custom_text/custom_poppins_text.dart';
import '../../components/custom_textfield/custom_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: const NetworkImage(
                            "https://c4.wallpaperflare.com/wallpaper/66/220/943/bmw-cars-car-sport-car-wallpaper-preview.jpg"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken))),
                child: const Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPoppinsText(
                      text: "BMW Store",
                      color: Colors.white,
                      fontSize: 30,
                    ),
                    CustomPoppinsText(
                      text: "Sign in to your account",
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ],
                )),
              ),
              Positioned(
                top: size.height * 0.26,
                child: Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Consumer<SignInProvider>(
                        builder: (context, value, child) {
                          return ListView(
                            children: [
                              CustomTextField(
                                prefixIcon: Icons.email,
                                label: "Email",
                                controller: value.emailController,
                              ),
                              CustomTextField(
                                prefixIcon: Icons.password,
                                label: "Password",
                                isPassword: true,
                                controller: value.passwordController,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPassword(),
                                        ));
                                  },
                                  child: CustomPoppinsText(
                                    text: "Forgot Password?",
                                    color: Colors.amber.shade800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CustomButton1(
                                colors: [
                                  Colors.amber.shade500,
                                  Colors.amber.shade800
                                ],
                                size: size,
                                text: "Sign In",
                                ontap: () {
                                  Provider.of<SignInProvider>(context,
                                          listen: false)
                                      .signInUser();
                                },
                              ),
                              CustomButton1(
                                colors: [
                                  Colors.grey.shade500,
                                  Colors.grey.shade800
                                ],
                                size: size,
                                text: "Create New Account",
                                ontap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpPage()));
                                },
                              )
                            ],
                          );
                        },
                      )),
                ),
              )
            ],
          )),
    );
  }
}
