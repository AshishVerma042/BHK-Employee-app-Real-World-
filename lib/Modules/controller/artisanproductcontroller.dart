import 'dart:convert';

import 'package:bhk_employee/Constants/utils.dart';
import 'package:get/get.dart';

import '../../common/CommonMethods.dart';
import '../../data/response/status.dart';
import '../../resources/strings.dart';
import '../model/getproductmodel.dart';
import '../repository/availableproductlist.dart';

class ArtisanProductController extends GetxController {
  final repository = ProductRepository();

  final List<Map<String, dynamic>> products = [
    {
      "name": "Handloom Saree",
      "id": "PRD001",
      "price": "₹1200",
      "stock": 15,
      "image": "assets/images/saree.jpg",
      "description": "Beautiful handloom cotton saree",
      "category": "Handloom",
      "material": "Cotton",
      "artisan": "Ramesh Kumar",
      "rating": 4.5,
    },
    {
      "name": "Wooden Craft",
      "id": "PRD002",
      "price": "₹800",
      "stock": 8,
      "image": "assets/images/Product3.png",
      "description": "Hand-carved wooden decorative item",
      "category": "Craft",
      "material": "Teak Wood",
      "artisan": "Sita Devi",
      "rating": 4.2,
    },
    {
      "name": "Clay Pot",
      "id": "PRD003",
      "price": "₹350",
      "stock": 25,
      "image": "assets/images/claypot.jpg",
      "description": "Eco-friendly clay pot for cooking",
      "category": "Pottery",
      "material": "Clay",
      "artisan": "Mohan Lal",
      "rating": 4.8,
    },
    {
      "name": "Handloom Saree",
      "id": "PRD001",
      "price": "₹1200",
      "stock": 15,
      "image": "assets/images/saree.jpg",
      "description": "Beautiful handloom cotton saree",
      "category": "Handloom",
      "material": "Cotton",
      "artisan": "Ramesh Kumar",
      "rating": 4.5,
    },
    {
      "name": "Wooden Craft",
      "id": "PRD002",
      "price": "₹800",
      "stock": 8,
      "image": "assets/images/Product3.png",
      "description": "Hand-carved wooden decorative item",
      "category": "Craft",
      "material": "Teak Wood",
      "artisan": "Sita Devi",
      "rating": 4.2,
    },
  ];
}
