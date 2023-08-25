import 'package:ce_store/components/custom_buttons/custom_button1.dart';
import 'package:ce_store/components/custom_text/custom_poppins_text.dart';
import 'package:ce_store/components/custom_textfield/custom_textfield.dart';
import 'package:ce_store/providers/admin_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Consumer<AdminProvider>(builder: (context, value, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CustomPoppinsText(text: "Add New Product"),
                  InkWell(
                      onTap: () {
                        value.pickImage(context);
                      },
                      child: value.image.path != ""
                          ? CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(value.image),
                            )
                          : Icon(
                              Icons.add_a_photo,
                              size: 100,
                              color: Colors.amber.shade800,
                            )),
                  CustomTextField(
                      label: "Item Name",
                      controller: value.nameController,
                      prefixIcon: Icons.car_repair),
                  CustomTextField(
                      label: "Item Description",
                      controller: value.descriptionController,
                      prefixIcon: Icons.description),
                  CustomTextField(
                      inputType: TextInputType.number,
                      label: "Price",
                      controller: value.priceController,
                      prefixIcon: Icons.price_change),
                  CustomTextField(
                      label: "Type",
                      controller: value.typeController,
                      prefixIcon: Icons.adjust_sharp),
                  CustomButton1(
                      colors: [Colors.grey.shade600, Colors.grey.shade900],
                      text: "Add Product",
                      size: size,
                      ontap: () {
                        value.addProduct(context);
                      })
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
