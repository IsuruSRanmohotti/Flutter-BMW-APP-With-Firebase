import 'package:ce_store/components/custom_buttons/custom_button1.dart';
import 'package:ce_store/components/custom_text/custom_poppins_text.dart';
import 'package:ce_store/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/car_model.dart';

class ProductDetails extends StatefulWidget {
  final Car car;
  const ProductDetails({super.key, required this.car});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<CartProvider>(builder: (context, value, child) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButton(onPressed: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      value.clearQuantity();
                    }),
                    Image.network(widget.car.image),
                    CustomPoppinsText(text: widget.car.name),
                    CustomPoppinsText(
                      text: "\$ ${widget.car.price.toString()}",
                      fontSize: 16,
                      fWeight: FontWeight.w600,
                    ),
                    Text(
                      widget.car.description,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const CustomPoppinsText(
                          text: "Quantity",
                          fontSize: 18,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius: BorderRadius.circular(25)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  value.decreaseQuantity();
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.amber.shade900,
                                  child: const Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                              CustomPoppinsText(
                                text: value.quantity.toString(),
                                color: Colors.white,
                                fontSize: 18,
                              ),
                              InkWell(
                                onTap: () {
                                  value.increseQuantity();
                                },
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.amber.shade900,
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: value.cartItems
                            .any((element) => element.car.id == widget.car.id)
                        ? CustomButton1(
                            colors: [Colors.red.shade500, Colors.red.shade800],
                            text: "Remove from cart",
                            size: size,
                            ontap: () {
                              value.addToCart(widget.car);
                            })
                        : CustomButton1(
                            colors: [
                                Colors.amber.shade500,
                                Colors.amber.shade800
                              ],
                            text: "Add To Cart",
                            size: size,
                            ontap: () {
                              value.addToCart(widget.car);
                            }))
              ],
            ));
      }),
    );
  }
}
