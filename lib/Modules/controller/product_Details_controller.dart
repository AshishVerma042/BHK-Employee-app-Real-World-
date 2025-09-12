import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  final String image;
  late Timer timer;
  var currentIndex = 0.obs;

  final carouselController = CarouselSliderController();

  final Rx<Duration> remaining = const Duration(hours: 2).obs;

  ProductController({required this.image});

  late final List<String> imagesfetch = [
    image.isNotEmpty ? image : "assets/images/ArticianImage1.jpg",
    "assets/images/ArticianImage1.jpg",
    "assets/images/ArticianImage4.jpg",
    "assets/images/ArticianImage1.jpg",
    "assets/images/ArticianImage4.jpg",
  ];

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (remaining.value.inSeconds > 0) {
        remaining.value = remaining.value - const Duration(seconds: 1);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String h = twoDigits(d.inHours);
    String m = twoDigits(d.inMinutes.remainder(60));
    String s = twoDigits(d.inSeconds.remainder(60));
    return "$h h $m m $s s";
  }
}
