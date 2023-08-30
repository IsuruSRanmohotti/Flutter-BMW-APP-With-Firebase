import 'package:ce_store/components/custom_text/custom_poppins_text.dart';
import 'package:ce_store/models/order_model.dart';
import 'package:ce_store/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Orders"),
      ),
      body: FutureBuilder(
        future: Provider.of<UserProvider>(context, listen: false).getMyOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          List<OrderModel> orders = snapshot.data!;
          Logger().w(orders.length);
          return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    height: 280,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomPoppinsText(
                          text: "Order Id - ${orders[index].id}",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        CustomPoppinsText(
                          text: "Items - ${orders[index].items.length}",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        CustomPoppinsText(
                          text: "Total - \$${orders[index].totalAmount}",
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                orders[index].items.length,
                                (i) => SizedBox(
                                      width: 112,
                                      height: 200,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          orders[index]
                                                              .items[i]
                                                              .car
                                                              .image)),
                                                  color: Colors.grey.shade400,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                            ),
                                            child: Text(
                                              orders[index].items[i].car.name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                            ),
                                            child: Text(
                                              "Quantity - ${orders[index].items[i].quantity}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                            ),
                                            child: Text(
                                              "\$ ${orders[index].items[i].car.price}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.orange),
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
