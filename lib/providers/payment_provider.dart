import 'package:ce_store/services/stripe_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:logger/logger.dart';

class PaymentProvider extends ChangeNotifier {
  StripeService service = StripeService();

  Future<void> getPayment(String totalAmount) async {
    dynamic intent = await service.requestPaymentIntent(totalAmount);

    if (intent != null) {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: intent['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: "Flutter Stripe"));

      await Stripe.instance.presentPaymentSheet().then((value) {
        Logger().w("Success - $totalAmount");
      });
    }
  }
}
