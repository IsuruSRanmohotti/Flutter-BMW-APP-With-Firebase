import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  final bool isPassword;
  final String label;
  final IconData prefixIcon;
  TextInputType inputType;
  CustomTextField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    required this.prefixIcon,
    this.inputType = TextInputType.text,
    super.key,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: widget.inputType,
        controller: widget.controller,
        obscureText: isObscure,
        decoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: Text(widget.label),
            prefixIcon: Icon(widget.prefixIcon),
            suffixIcon: widget.isPassword == true
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    child: Icon(
                        isObscure ? Icons.visibility : Icons.visibility_off))
                : null),
      ),
    );
  }
}
