import 'package:get/get.dart';

class ProductController extends GetxController {
  var images = <String>[].obs;

  var selectedIndex = 0.obs;

  void setImages(List<String> imgList) {
    images.assignAll(imgList);
    selectedIndex.value = 0;
  }

  void changeImage(int index) {
    if (index >= 0 && index < images.length) {
      selectedIndex.value = index;
    }
  }
}
