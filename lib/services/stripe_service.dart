import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

class StripeService {
  Future<Map<String, dynamic>?> requestPaymentIntent(String totalAmount) async {
    try {
      Response response = await post(
          Uri.parse("https://api.stripe.com/v1/payment_intents"),
          headers: {
            "Authorization":
                "Bearer sk_test_51NdDomJFWrzBUHnSFDehtJP2eFdWAldKnmAUeYQva9DU5dNjY87tFPv8AqhTiSnnciDU94ueiFkEBea7LTi6qxEy00eoXZAlP1",
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: {
            "amount": (int.parse(totalAmount) * 100).toString(),
            "currency": "LKR"
          });
      Logger().e(response.body);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }
}
