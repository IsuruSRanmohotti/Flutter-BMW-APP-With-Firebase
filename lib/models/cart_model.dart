import 'package:ce_store/models/car_model.dart';
import 'package:logger/logger.dart';

class CartModel {
  int quantity;
  Car car;

  CartModel({required this.car, required this.quantity});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    
    return CartModel(
      car: Car.fromJson(json["car"] as Map<String, dynamic>),
      quantity: (json['quantity'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return {"quantity": quantity, "car": car.toJson()};
  }
}
