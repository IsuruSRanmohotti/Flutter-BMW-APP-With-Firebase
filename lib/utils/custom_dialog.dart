import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
            child: SpinKitThreeInOut(
          color: Colors.white,
        ));
      },
    );
  }

  static void dismiss(BuildContext context) {
    Navigator.pop(context);
  }

  static void toast(context, msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        webPosition: "center",
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.grey.shade800,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
