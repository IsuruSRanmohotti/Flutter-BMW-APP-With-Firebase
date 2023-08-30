import 'dart:io';

import 'package:ce_store/controllers/home_slider_controller.dart';
import 'package:ce_store/controllers/storage_ontroller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/custom_dialog.dart';

class HomeSliderProvider extends ChangeNotifier {
  File _image = File("");
  ImagePicker picker = ImagePicker();
  List<String> _sliderImages = ["", "", "", "", "", ""];
  List<String> get sliderImages => _sliderImages;

  Future<void> pickImage(context, index) async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = File(pickedImage.path);

      _sliderImages[index] = _image.path;
      notifyListeners();
      CustomDialog.show(context);
      String imgUrl =
          await StorageController().uploadImage(_image, "Home Slider Images");
      HomeSliderController().addSliderImage(index, imgUrl, context);
    } else {
      CustomDialog.toast(context, "Image Picker Cancelled");
    }
  }

  void updateSliderImageList(List<String> list) {
    _sliderImages = list;
    notifyListeners();
  }
}
