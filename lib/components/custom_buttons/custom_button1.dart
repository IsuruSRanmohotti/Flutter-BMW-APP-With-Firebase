import 'package:flutter/material.dart';

import '../custom_text/custom_poppins_text.dart';

class CustomButton1 extends StatelessWidget {
  final String text;
  final List<Color> colors;
  final VoidCallback ontap;
  const CustomButton1(
      {required this.colors,
      required this.text,
      super.key,
      required this.size,
      required this.ontap});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: size.width * 0.8,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(colors: colors)),
          child: Center(
            child: CustomPoppinsText(
              text: text,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
