import 'package:ce_store/models/order_model.dart';
import 'package:ce_store/utils/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../screens/orders/my_orders.dart';
import '../utils/navigator_utils.dart';

class OrderController {
  final CollectionReference order =
      FirebaseFirestore.instance.collection("Orders");

  Future<void> saveOrder(OrderModel oModel, BuildContext context) async {
    try {
      String docId = order.doc().id;
      oModel.id = docId;
      Map<String, dynamic> orderJson = oModel.toJson();

      await order.doc(docId).set(orderJson).then((value) {
        Logger().w("Order Saved");
        CustomDialog.dismiss(context);
        CustomNavigator.goTo(context, const MyOrders());
      });
    } catch (e) {
      Logger().e(e);
      CustomDialog.dismiss(context);
    }
  }

  Future<List<OrderModel>> fetchMyOrders(String uid) async {
    List<OrderModel> orders = [];
    QuerySnapshot snapshot =
        await order.where("user.uid", isEqualTo: uid).get();

    for (var order in snapshot.docs) {
      OrderModel myOrder =
          OrderModel.fromJson(order.data() as Map<String, dynamic>);

      orders.add(myOrder);
    }
    return orders;
  }
}
