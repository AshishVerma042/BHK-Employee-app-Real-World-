import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/colors.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/appconstants.dart';
import '../../../routes/RoutesClass.dart';
import '../../controller/artisanproductcontroller.dart';

class ProductScreen extends ParentWidget {
  const ProductScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(ArtisanProductController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: AppBar(
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Products",
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: controller.products.isEmpty
            ? Center(
                child: Text(
                  "No products found",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey.shade600),
                ),
              )
            : ListView.builder(
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return productCard(product);
                },
              ),
      ),
    );
  }
}

Widget productCard(Map<String, dynamic> product) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    decoration: BoxDecoration(
      color: appColors.cardBackground,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))],
    ),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(product["image"], height: 70, width: 70, fit: BoxFit.cover),
              ),
              12.kW,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product["name"],
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        ),

                      ],
                    ),

                    const SizedBox(height: 4),
                    Text(
                      product["description"],
                      style:  TextStyle(fontSize: 13, color: Colors.black87),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    6.kH,
                    Text("ID: ${product["id"]}", style: const TextStyle(fontSize: 12, color: Colors.black87)),
                  ],
                ),
              ),
            ],
          ),
          10.kH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Category: ${product["category"] }", style: const TextStyle(fontSize: 12, color: Colors.black87)),

            ],
          ),
          6.kH,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Material: ${product["material"] }", style: const TextStyle(fontSize: 12, color: Colors.black87)),
              Text("Stock: ${product["stock"]}", style: const TextStyle(fontSize: 12, color: Colors.black87)),
            ],
          ),
          6.kH,
          Divider(color: Colors.green),


          Row(
            children: [Text("By: ${product["artisan"]}", style: const TextStyle(fontSize: 12, color: Colors.black87))],
          ),

        ],
      ),
    ),
  );
}
