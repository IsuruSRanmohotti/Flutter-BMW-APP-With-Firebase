import 'package:ce_store/components/custom_buttons/custom_button1.dart';
import 'package:ce_store/components/custom_text/custom_poppins_text.dart';
import 'package:ce_store/components/custom_textfield/custom_textfield.dart';
import 'package:ce_store/controllers/auth_controller.dart';
import 'package:ce_store/providers/user_provider.dart';
import 'package:ce_store/screens/home/admin/add_product.dart';
import 'package:ce_store/screens/home_slider/slider_update.dart';
import 'package:ce_store/screens/orders/my_orders.dart';
import 'package:ce_store/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Consumer<UserProvider>(builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {
                  value.pickImage();
                },
                child: value.image.path != ""
                    ? CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(value.image),
                      )
                    : CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(value.userData!.userImage),
                      )),
            CustomPoppinsText(
              text: Provider.of<UserProvider>(context).userData!.email,
              fontSize: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                CustomNavigator.goTo(context, const MyOrders());
              },
              child: Container(
                width: 100,
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.orange.shade800,
                    borderRadius: BorderRadius.circular(35)),
                child: const Center(
                  child: CustomPoppinsText(
                    text: "My Orders",
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
                label: "Name",
                controller: value.nameController,
                prefixIcon: Icons.person),
            const SizedBox(
              height: 15,
            ),
            CustomButton1(
                colors: [Colors.amber.shade600, Colors.amber.shade900],
                text: "Update",
                size: size,
                ontap: () {
                  value.updateProfileData(context);
                }),
            const SizedBox(
              height: 4,
            ),
            CustomButton1(
                colors: [Colors.amber.shade600, Colors.amber.shade900],
                text: "Add Product",
                size: size,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddProduct(),
                      ));
                }),
            const SizedBox(
              height: 4,
            ),
            CustomButton1(
                colors: [Colors.amber.shade600, Colors.amber.shade900],
                text: "Update Home Slider",
                size: size,
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpdateSlider(),
                      ));
                }),
            const SizedBox(
              height: 4,
            ),
            CustomButton1(
                colors: [Colors.grey.shade600, Colors.grey.shade900],
                text: "Sign Out",
                size: size,
                ontap: () {
                  AuthController.signOutUser();
                })
          ],
        );
      }),
    );
  }
}
