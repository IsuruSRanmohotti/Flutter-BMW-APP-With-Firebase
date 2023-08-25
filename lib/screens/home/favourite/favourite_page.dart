import 'package:ce_store/components/custom_text/custom_poppins_text.dart';
import 'package:ce_store/providers/user_provider.dart';
import 'package:ce_store/screens/product_view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<UserProvider>(builder: (context, value, child) {
          return value.favouriteItems.isNotEmpty
              ? Column(
                  children: [
                    const CustomPoppinsText(
                      text: "Favourite Items",
                      fontSize: 22,
                      fWeight: FontWeight.w500,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: value.favouriteItems.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetails(
                                        car: value.favouriteItems[index]),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Image.network(
                                        value.favouriteItems[index].image,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomPoppinsText(
                                          text:
                                              value.favouriteItems[index].name,
                                          fontSize: 18,
                                          fWeight: FontWeight.w500,
                                        ),
                                        CustomPoppinsText(
                                          text:
                                              "\$ ${value.favouriteItems[index].price}",
                                          fontSize: 18,
                                          fWeight: FontWeight.w500,
                                          color: Colors.amber.shade900,
                                        ),
                                      ],
                                    ),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          value.removeFromFavourite(context,
                                              value.favouriteItems[index]);
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )
              : const Center(
                  child: CustomPoppinsText(text: "No Favourite Items"),
                );
        }),
      )),
    );
  }
}
