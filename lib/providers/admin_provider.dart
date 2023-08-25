import 'dart:io';

import 'package:ce_store/controllers/storage_ontroller.dart';
import 'package:ce_store/models/car_model.dart';
import 'package:ce_store/utils/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminProvider extends ChangeNotifier {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  File _image = File("");
  ImagePicker picker = ImagePicker();
  CollectionReference product =
      FirebaseFirestore.instance.collection("Products");

  TextEditingController get nameController => _nameController;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get typeController => _typeController;
  TextEditingController get priceController => _priceController;
  File get image => _image;

  Future<void> addProduct(context) async {
    if (_nameController.text.isEmpty) {
      CustomDialog.toast(context, "Insert Product Name");
    } else if (_descriptionController.text.isEmpty) {
      CustomDialog.toast(context, "Insert Product Description");
    } else if (_priceController.text.isEmpty) {
      CustomDialog.toast(context, "Insert Product Price");
    } else if (_typeController.text.isEmpty) {
      CustomDialog.toast(context, "Insert Vehicle Type");
    } else if (_image.path == "") {
      CustomDialog.toast(context, "Add Product Image");
    } else {
      CustomDialog.show(context);
      String imageUrl =
          await StorageController().uploadImage(_image, "Product Images");
      await product.add({
        "name": _nameController.text,
        "description": _descriptionController.text,
        "price": _priceController.text,
        "type": _typeController.text,
        "image": imageUrl
      }).then((value) {
        product.doc(value.id).update({"id": value.id});
        CustomDialog.toast(context, "Product Added");
        CustomDialog.dismiss(context);
        _descriptionController.clear();
        _nameController.clear();
        _priceController.clear();
        _typeController.clear();
        _image = File("");
        notifyListeners();
        return value;
      });
    }
  }

  Future<void> pickImage(context) async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = File(pickedImage.path);
      notifyListeners();
    } else {
      CustomDialog.toast(context, "Image Picker Cancelled");
    }
  }

  Future<List<Car>> fetchProducts() async {
    QuerySnapshot snapshot = await product.get();
    List<Car> cars = [];
    for (var e in snapshot.docs) {
      Car car = Car.fromJson(e.data() as Map<String, dynamic>);
      cars.add(car);
    }
    return cars;
  }
}
