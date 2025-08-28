import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../controller/product_Details_controller.dart';

class ProductDetailScreen extends ParentWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar:  AppBar(
        flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
        iconTheme: const IconThemeData(color: Colors.white),
        title:   Text(
          product['name'] ?? "Product",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    child: Image.asset(
                      product['image'] ?? "assets/images/placeholder.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(product.length, (index) {
                      return Container(
                        margin:  EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: index == 0 ? Colors.white : Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
        SizedBox(height: 4,),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: product.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => controller.selectedIndex.value = index,
                child: Obx(
                      () => Container(
                    margin:  EdgeInsets.symmetric(horizontal: 6),
                    padding:  EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: controller.selectedIndex.value == index
                            ? Colors.brown
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      child: Image.asset(
                        product['image'] ?? "assets/images/placeholder.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8,top: 20),
              child: Text(
                product['name'] ?? "Unknown Product",
                style:  TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.3,
                ),
              ),
            ),




            Container(
              padding:  EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                   SizedBox(height: 14),

                  Text(
                    product['description'] ??
                        "This is a high-quality handcrafted product by skilled artisans. Perfect for gifting and daily use.",
                    style:  TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  20.kH,
                  Row(
                    children: [
                      Text(
                        "Rs. ${product['price'] ?? "0"}",
                        style:  TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      4.kW,
                      Text("MRP",style: TextStyle(fontSize: 12),)
                    ],
                  ),
                  Text("Including all the texes",style: TextStyle(fontSize: 12),)
                ],
              ),
            ),
            Divider(
              thickness: 3,
              color: Colors.grey[300],
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:  8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Available Quantity",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Container(height: 25, width: 40,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)),color: Colors.transparent,border: Border.all(color: Colors.red,width: 1)),
                  child: Center(child: Text('20')),
                  )
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              margin:  EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              padding:  EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Product Details",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                   SizedBox(height: 12),
                  detailRow("Category", product['category'] ?? "Handloom"),
                  detailRow("Material", product['material'] ?? "Cotton"),
                  detailRow("Size", product['size'] ?? "Medium"),
                  detailRow("Stock", product['stock'] ?? "Available"),
                  detailRow("Dimension", product['stock'] ?? '8" X 8" X 16"'),
                  detailRow("NetWeight", product['stock'] ?? '850gm'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Quality Assurance",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Quality Score",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black)),
                          Text(" 9.2/10",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Column(
                    children:  [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconText( Icons.check,  "Authenticity Verified"),
                          IconText( Icons.check, "Quality Inspected"),
                        ],
                      ),
                      16.kH,

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconText( Icons.check,  "Damage Protection"),
                          IconText( Icons.check,  "Insured Shipping"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Quality Inspection Report",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  reportRow("Craftsmanship", "Excellent"),
                  reportRow("Material Grade", "Premium"),
                  reportRow("Finish Quality", "Superior"),
                  reportRow("Structural Integrity", "Perfect"),
                ],
              ),
            ),
            30.kH
          ],
        ),
      ),
    );
  }



  Widget detailRow(String title, String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style:  TextStyle(fontSize: 14, color: Colors.black54),
          ),
          2.kH,
          Text(
            value,
            style:  TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}


Widget IconText(IconData icon, String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, color: Colors.green, size: 18),
      SizedBox(width: 6),
      Text(text, style:  TextStyle(fontSize: 14)),
    ],
  );
}

Widget reportRow(String title, String value) {
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style:  TextStyle(fontSize: 14, color: Colors.black54)),
        Text(value,
            style:  TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.green)),
      ],
    ),
  );
}
