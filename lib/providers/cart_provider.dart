import 'package:ce_store/controllers/order_controller.dart';
import 'package:ce_store/models/car_model.dart';
import 'package:ce_store/models/cart_model.dart';
import 'package:ce_store/models/order_model.dart';
import 'package:ce_store/models/user_model.dart';
import 'package:ce_store/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  OrderController oController = OrderController();
  int _quantity = 1;
  int get quantity => _quantity;
  List<CartModel> _cartItems = [];
  List<CartModel> get cartItems => _cartItems;
  double _total = 0;

  void increseQuantity() {
    _quantity++; //_quantity = _quantity + 1;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (_quantity != 1) {
      _quantity--;
      notifyListeners();
    }
  }

  void addToCart(Car car) {
    if (_cartItems.any((element) => element.car.id == car.id)) {
      _cartItems.removeWhere((element) => element.car.id == car.id);
      notifyListeners();
    } else {
      _cartItems.add(CartModel(car: car, quantity: _quantity));
      clearQuantity();
      notifyListeners();
    }
  }

  void clearQuantity() {
    _quantity = 1;
    notifyListeners();
  }

  void clearCart() {
    _total = 0;
    _cartItems = [];
    notifyListeners();
  }

  void increseCartItemQuantity(int index) {
    _cartItems[index].quantity++;
    notifyListeners();
  }

  void decreseCartItemQuantity(int index) {
    if (_cartItems[index].quantity != 1) {
      _cartItems[index].quantity--;
      notifyListeners();
    }
  }

  double calculateTotal() {
    double total = 0;
    for (var item in _cartItems) {
      total += item.car.price * item.quantity;
    }
    _total = total;
    return total;
  }

  Future<void> saveOrderDetails(BuildContext context) async {
    UserModel user =
        Provider.of<UserProvider>(context, listen: false).userData!;

    OrderModel oModel = OrderModel(
      totalAmount: _total,
      id: "",
      items: _cartItems,
      user: user,
    );
    oController.saveOrder(oModel, context);
  }
}
