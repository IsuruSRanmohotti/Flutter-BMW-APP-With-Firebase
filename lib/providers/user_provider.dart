import 'dart:io';

import 'package:ce_store/controllers/auth_controller.dart';
import 'package:ce_store/controllers/home_slider_controller.dart';
import 'package:ce_store/controllers/order_controller.dart';
import 'package:ce_store/controllers/storage_ontroller.dart';
import 'package:ce_store/models/car_model.dart';
import 'package:ce_store/models/order_model.dart';
import 'package:ce_store/models/user_model.dart';
import 'package:ce_store/providers/home_slider_provider.dart';
import 'package:ce_store/utils/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../screens/auth/signup_page.dart';
import '../screens/home/main_screen.dart';
import '../utils/navigator_utils.dart';

class UserProvider extends ChangeNotifier {
  final OrderController oController = OrderController();
  List<String> _favItems = [];
  List<String> get favItems => _favItems;
  List<Car> _favouriteItems = [];
  List<Car> get favouriteItems => _favouriteItems;
  UserModel? _user;
  UserModel? get userData => _user;
  final TextEditingController _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;
  ImagePicker picker = ImagePicker();
  File _image = File("");
  File get image => _image;
  //Check Current User Auth State

  Future<void> checkAuthState(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          CustomNavigator.goTo(context, const SignUpPage());
          Logger().e('User is currently signed out!');
        } else {
          fetchData(user.uid, context).then((value) {
            CustomNavigator.goTo(context, const MainScreen());
            Logger().i('User is signed in! --- $user');
          });
        }
      });
    });
  }

  Future<void> fetchData(uid, context) async {
    _user = await AuthController().getUserData(uid);
    List<String> list = await HomeSliderController().getSliderImages();
    Logger().e(list);
    Provider.of<HomeSliderProvider>(context ,listen: false).updateSliderImageList(list);
    _favItems = _user!.favourite;
    setUserName(_user!.name);
    notifyListeners();
  }

  CollectionReference users = FirebaseFirestore.instance.collection("Users");

  Future<void> updateProfileData(BuildContext context) async {
    CustomDialog.show(context);
    if (_image.path != "") {
      String imageUrl =
          await StorageController().uploadImage(_image, "User Images");
      users.doc(_user!.uid).update(
          {"name": _nameController.text, "userImage": imageUrl}).then((value) {
        CustomDialog.toast(context, "User Updated");
        CustomDialog.dismiss(context);
      });
    } else {
      users
          .doc(_user!.uid)
          .update({"name": _nameController.text}).then((value) {
        CustomDialog.dismiss(context);
        CustomDialog.toast(context, "User Updated");
      });
    }
  }

  void setUserName(String name) {
    _nameController.text = name;
    notifyListeners();
  }

  Future<void> pickImage() async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = File(pickedImage.path);
      notifyListeners();
      Logger().i(_image.path);
    } else {
      Logger().e("Try again");
    }
  }

  void addToFavourite(BuildContext context, Car car) {
    _favItems.add(car.id);
    _favouriteItems.add(car);
    users.doc(_user!.uid).update({"favourite": _favItems}).then((value) {
      CustomDialog.toast(context, "Added to Favourite");
    });
    notifyListeners();
  }

  void removeFromFavourite(BuildContext context, Car car) {
    _favItems.remove(car.id);
    _favouriteItems.remove(car);
    users.doc(_user!.uid).update({"favourite": _favItems}).then((value) {
      CustomDialog.toast(context, "Removed From Favourite");
    });
    notifyListeners();
  }

  void filterFavouriteItems(List<Car> cars) {
    List<Car> filteredList = [];
    for (var car in cars) {
      if (_favItems.contains(car.id) && !_favouriteItems.contains(car)) {
        filteredList.add(car);
      }
    }
    _favouriteItems = filteredList;
    notifyListeners();
  }

  Future<List<OrderModel>> getMyOrders() async {
    List<OrderModel> orders = await oController.fetchMyOrders(_user!.uid);

    return orders;
  }
}
