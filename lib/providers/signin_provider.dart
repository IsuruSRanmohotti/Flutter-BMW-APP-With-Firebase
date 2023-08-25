import 'package:ce_store/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

class SignInProvider extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _recoveryEmailController =
      TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get recoveryEmailController => _recoveryEmailController;

  Future<void> signInUser() async {
    if (_emailController.text.isEmpty) {
      Logger().e("Check Your Email");
    } else if (_passwordController.text.isEmpty) {
      Logger().e("Check Your Password");
    } else {
      AuthController.signInToAccount(
              emailAddress: _emailController.text,
              password: _passwordController.text)
          .then((value) {
        _emailController.text = "";
        _passwordController.text = "";
      });
    }
  }

  Future<void> sendResetEmail(BuildContext context) async {
    if (_recoveryEmailController.text.isEmpty) {
      Logger().e("Check Your Email");
    } else {
      AuthController.sedPasswordResetEmail(_recoveryEmailController.text)
          .then((value) {
        Fluttertoast.showToast(
            msg: "Email Sent to ${_recoveryEmailController.text}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            webPosition: "center",
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        _recoveryEmailController.text = "";
        Navigator.pop(context);
      });
    }
  }
}
