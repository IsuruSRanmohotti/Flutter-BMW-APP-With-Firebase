import 'package:ce_store/providers/admin_provider.dart';
import 'package:ce_store/providers/cart_provider.dart';
import 'package:ce_store/providers/home_slider_provider.dart';
import 'package:ce_store/providers/homepage_provider.dart';
import 'package:ce_store/providers/payment_provider.dart';
import 'package:ce_store/providers/signin_provider.dart';
import 'package:ce_store/providers/signup_provider.dart';
import 'package:ce_store/providers/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey = dotenv.env["PUBLISHABLE_KEY"]!;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SignInProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomePageProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AdminProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => CartProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => PaymentProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeSliderProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMW',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
