import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProductController extends GetxController {
  final String image;

  ProductController({required this.image});

  late final List<String> imagesfetch = [
    image.isNotEmpty ? image : "assets/images/ArticianImage1.jpg",
    "assets/images/ArticianImage1.jpg",
    "assets/images/ArticianImage4.jpg",
    "assets/images/ArticianImage1.jpg",
    "assets/images/ArticianImage4.jpg",

  ];


}
