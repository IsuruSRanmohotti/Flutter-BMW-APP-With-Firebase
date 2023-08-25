import 'package:ce_store/providers/signup_provider.dart';
import 'package:ce_store/screens/auth/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_buttons/custom_button1.dart';
import '../../components/custom_text/custom_poppins_text.dart';
import '../../components/custom_textfield/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
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
                              Colors.black.withOpacity(0.5),
                              BlendMode.darken))),
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
                        text: "Create new user account",
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
                      child: ListView(
                        children: [
                          CustomTextField(
                            prefixIcon: Icons.email,
                            label: "Email",
                            controller: Provider.of<SignUpProvider>(context)
                                .emailController,
                          ),
                          CustomTextField(
                            prefixIcon: Icons.emoji_people,
                            label: "Name",
                            controller: Provider.of<SignUpProvider>(context)
                                .nameController,
                          ),
                          CustomTextField(
                            prefixIcon: Icons.password,
                            label: "Password",
                            isPassword: true,
                            controller: Provider.of<SignUpProvider>(context)
                                .passwordController,
                          ),
                          CustomTextField(
                            prefixIcon: Icons.password,
                            label: "Confirm Password",
                            isPassword: true,
                            controller: Provider.of<SignUpProvider>(context)
                                .confirmPassowrdController,
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
                            text: "Create Account",
                            ontap: () {
                              Provider.of<SignUpProvider>(context,
                                      listen: false)
                                  .signUpUser();
                            },
                          ),
                          CustomButton1(
                            colors: [
                              Colors.grey.shade500,
                              Colors.grey.shade800
                            ],
                            size: size,
                            text: "Sign In",
                            ontap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
