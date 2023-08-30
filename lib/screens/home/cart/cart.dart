import 'package:ce_store/components/custom_buttons/custom_button1.dart';
import 'package:ce_store/components/custom_text/custom_poppins_text.dart';
import 'package:ce_store/providers/cart_provider.dart';
import 'package:ce_store/providers/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/car_model.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  List<Car> cars = [];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: const CustomPoppinsText(
              text: "My Cart", fWeight: FontWeight.w500, fontSize: 20),
        ),
        body: Consumer<CartProvider>(builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.cartItems.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              value.cartItems[index].car.image,
                              width: 100,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomPoppinsText(
                                  text: value.cartItems[index].car.name,
                                  fontSize: 16,
                                ),
                                CustomPoppinsText(
                                  text:
                                      "\$ ${value.cartItems[index].car.price}",
                                  fontSize: 16,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade700,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          value.decreseCartItemQuantity(index);
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              Colors.amber.shade900,
                                          child: const Icon(
                                            Icons.remove,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      CustomPoppinsText(
                                        text: value.cartItems[index].quantity
                                            .toString(),
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          value.increseCartItemQuantity(index);
                                        },
                                        child: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:
                                              Colors.amber.shade900,
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                CustomPoppinsText(
                                  text:
                                      "Total - ${(value.cartItems[index].car.price * value.cartItems[index].quantity)}",
                                  fontSize: 15,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomPoppinsText(
                            text: "Total",
                            fontSize: 18,
                          ),
                          CustomPoppinsText(
                            text: value.cartItems.isNotEmpty
                                ? "\$ ${value.calculateTotal()}"
                                : "\$ 0",
                            fontSize: 18,
                            fWeight: FontWeight.bold,
                          )
                        ],
                      ),
                      CustomButton1(
                          colors: [
                            Colors.amber.shade500,
                            Colors.amber.shade800
                          ],
                          text: "Buy Now",
                          size: size,
                          ontap: () {
                            Provider.of<PaymentProvider>(context, listen: false)
                                .getPayment(
                                    value.calculateTotal().toInt().toString(),
                                    context);
                          })
                    ],
                  ),
                ),
              ),
            ],
          );
        }));
  }
}
