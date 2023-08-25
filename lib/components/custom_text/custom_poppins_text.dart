import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPoppinsText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fWeight;
  final Color color;
  final TextOverflow textOverflow;
  const CustomPoppinsText({
    required this.text,
    this.fontSize = 24,
    this.textOverflow = TextOverflow.visible,
    this.color = Colors.black,
    this.fWeight = FontWeight.w500,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fWeight,
        color: color,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }
}
