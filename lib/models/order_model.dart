import 'package:ce_store/models/cart_model.dart';
import 'package:ce_store/models/user_model.dart';
import 'package:logger/logger.dart';

class OrderModel {
  List<CartModel> items;
  UserModel user;
  String id;
  double totalAmount;

  OrderModel(
      {required this.totalAmount,
      required this.id,
      required this.items,
      required this.user});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    try {
      List<CartModel> items = (json['items'] as List<dynamic>)
          .map((e) => CartModel.fromJson(e))
          .toList();

      return OrderModel(
        totalAmount: (json["totalAmount"] as num).toDouble(),
        id: json['id'],
        items: items,
        user: UserModel.fromMap(json["user"] as Map<String, dynamic>),
      );
    } catch (e) {
      Logger().e(e);
      return OrderModel(
          totalAmount: 0,
          id: "",
          items: [],
          user: UserModel(
              email: "", name: "", uid: "", userImage: "", favourite: []));
    }
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> itemMapList =
        (items.map((e) => e.toJson())).toList();

    return {
      "items": itemMapList,
      "user": user.toJson(),
      "id": id,
      "totalAmount": totalAmount
    };
  }
}
