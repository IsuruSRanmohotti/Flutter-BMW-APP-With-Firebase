import 'package:ce_store/providers/homepage_provider.dart';
import 'package:ce_store/screens/home/cart/cart.dart';
import 'package:ce_store/screens/home/favourite/favourite_page.dart';
import 'package:ce_store/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_page/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _mainPages = [
    const HomePage(),
    const FavouritePage(),
    const MyCart(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(builder: (context, value, child) {
      return Scaffold(
        body: _mainPages[value.currentIndex],
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNBIcon(
              icon: Icons.home,
              isActive: value.currentIndex == 0,
              text: "Home",
              onTap: () {
                value.changeIndex(0);
              },
            ),
            BottomNBIcon(
              icon: Icons.favorite,
              isActive: value.currentIndex == 1,
              text: "Favourite",
              onTap: () {
                value.changeIndex(1);
              },
            ),
            BottomNBIcon(
              icon: Icons.shopping_cart,
              isActive: value.currentIndex == 2,
              text: "My Cart",
              onTap: () {
                value.changeIndex(2);
              },
            ),
            BottomNBIcon(
              icon: Icons.person,
              isActive: value.currentIndex == 3,
              text: "Profile",
              onTap: () {
                value.changeIndex(3);
              },
            ),
          ],
        ),
      );
    });
  }
}

class BottomNBIcon extends StatelessWidget {
  const BottomNBIcon(
      {super.key,
      required this.icon,
      required this.isActive,
      required this.onTap,
      required this.text});
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Column(
        children: [
          IconButton(
              onPressed: onTap,
              icon: Icon(
                icon,
                color: isActive ? Colors.amber.shade800 : Colors.grey.shade500,
              )),
          Text(text)
        ],
      ),
    );
  }
}
