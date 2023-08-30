import 'package:ce_store/utils/custom_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeSliderController {
  CollectionReference sliderImage =
      FirebaseFirestore.instance.collection("Home Slider Images");
  Future<void> addSliderImage(index, imgUrl, context) async {
    try {
      await sliderImage
          .doc((index + 1).toString())
          .set({"image": imgUrl}).then((value) {
        CustomDialog.dismiss(context);
        CustomDialog.toast(context, "Home Slider Image Updated");
      });
    } catch (e) {
      CustomDialog.dismiss(context);
      CustomDialog.toast(context, e.toString());
    }
  }

  Future<List<String>> getSliderImages() async {
    List<String> sliderImages = [];
    QuerySnapshot snapshot = await sliderImage.get();

    for (var element in snapshot.docs) {
      String url = (element.data() as Map<String, dynamic>)['image'];
      sliderImages.add(url);
    }
    return sliderImages;
  }
}
