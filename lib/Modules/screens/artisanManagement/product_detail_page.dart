import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../controller/product_Details_controller.dart';

class ProductDetailScreen extends ParentWidget {
  final Map<String, dynamic> product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final ProductController productController = Get.put(ProductController(image: product['image']));

    // final List<String> images = [
    //   product['image'] ?? "assets/images/ArticianImage1.jpg",
    //   "assets/images/ArticianImage1.jpg",
    //   "assets/images/ArticianImage4.jpg",
    //   "assets/images/ArticianImage1.jpg",
    //   "assets/images/ArticianImage4.jpg",
    //   "assets/images/ArticianImage1.jpg",
    //   "assets/images/ArticianImage4.jpg",
    //   "assets/images/ArticianImage1.jpg",
    //   "assets/images/ArticianImage4.jpg"
    // ];

    return DefaultTabController(
      length: productController.imagesfetch.length,
      child: Scaffold(
        backgroundColor: appColors.backgroundColor,
        appBar: AppBar(
          flexibleSpace: Container(
              decoration:
               BoxDecoration(gradient: AppConstants.customGradient)),
          iconTheme:  IconThemeData(color: Colors.white),
          title: Text(
            product['name'] ?? "Product",
            style:  TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 510,
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        children: productController.imagesfetch.map((img) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16,left: 16.0,top: 16),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              child: Image.asset(
                                img,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 8),

                    SizedBox(
                      height: 80,
                      child: Padding(
                        padding:  EdgeInsets.only(left: 12.0),
                        child: TabBar(
                          labelPadding: EdgeInsets.symmetric(horizontal: 1),
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          dividerColor: Colors.transparent,
                          indicator: BoxDecoration(
                            border: Border.all(color: Colors.brown, width: 2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          tabs: productController.imagesfetch.map((img) {
                            return Padding(padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  img,
                                  height: 70,
                                  width: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding:
                 EdgeInsets.only(left: 14.0, right: 14, top: 40),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'] ?? "Unknown Product",
                      style:  TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
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
                          "₹ ${product['price'] ?? "0"}",
                          style:  TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        5.kW,
                        Text("MRP",
                            style: TextStyle(fontSize: 13)),
                      ],
                    ),
                    Text("Including all the taxes",
                        style: TextStyle(fontSize: 13)),
                  ],
                ),
              ),

              Divider(
                thickness: 3,
                color: Colors.grey[300],
                indent: 14,
                endIndent: 14,
              ),

              Padding(
                padding:
                 EdgeInsets.symmetric(horizontal: 20.0,vertical: 12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Text("Available Quantity",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold)),
                        Container(
                          height: 28,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.brown, width: 1.6)),
                          child:  Center(child: Text('20')),
                        )
                      ],
                    ),
                    28.kH,
                    Text(
                      "Product Details",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    12.kH,
                    detailRow("Material", "High-grade ceramic with natural clay base"),
                    detailRow("NetWeight", '850gm'),
                    detailRow("Art Technique", "Traditional pottery wheel throwing"),
                    detailRow("Dimension", '8\" X 8\" X 16\"'),

                    detailRow("Texture", "Matte glazed finish with textured bands"),
                    detailRow("Pattern", "Geometric relief patterns with organic motifs"),
                    8.kH,
                    Text("Care Instructions",style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black45),),
                    2.kH,
                    Container(margin: EdgeInsets.symmetric(vertical: 12),height: 60,width: double.infinity,decoration: BoxDecoration(
                        color:Color.fromARGB(27, 96, 61, 1) ,borderRadius: BorderRadius.all(Radius.circular(12))
                    ),
                      child: Center(child: Text("Hand wash with mild soap, avoid abrasive cleaners",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500),)),
                    ),
                    20.kH,
                   auction(context),
                    28.kH,
                    assurance(),
                    28.kH,
                    inspectionReport(),
                    18.kH
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:  TextStyle(fontSize: 14, fontWeight: FontWeight.w500,color: Colors.black45)),
          2.kH,
          Text(value,
              style:  TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black)),
        ],
      ),
    );
  }
}

Widget IconText(String text) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
       Icon(Icons.task_alt_sharp,
          color: Colors.green, size: 18),
       SizedBox(width: 6),
      Text(text, style:  TextStyle(fontSize: 14,fontWeight: FontWeight.w500)),
    ],
  );
}

Widget reportRow(String title, String value) {
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style:
             TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.black45)),
        Text(value,
            style:  TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.green)),
      ],
    ),
  );
}

Widget auction (context){
  return Column(
    children: [
      Row(
        children: [
          Text("Live Auction",style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
          4.kW,
          Container(height: 12,width: 12,decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.all(Radius.circular(16))),)
        ],
      ),
      Container(
        margin:  EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color:  Color.fromARGB(27, 96, 61, 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          contentPadding:  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/images/Profile.png",
              height: 50,
              width: 46,
              fit: BoxFit.cover,
            ),
          ),
          title: Row(
            children: [
              Text(
                "Alex Chen",
                style:  TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
               SizedBox(width: 6),
              Container(
                padding:  EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child:  Text(
                  "Latest Bid",
                  style: TextStyle(color: Colors.green,fontSize: 11, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          subtitle:  Text(
            "2 minutes ago",
            style: TextStyle( color: Colors.black54),
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              Text(
                "₹258",
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2),
              Text(
                "Current Highest",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          onTap: () {
          },
        ),
      ),
      12.kH,
      Container(
        margin:  EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:  Color.fromARGB(27, 96, 61, 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.gavel,color: Colors.brown,size: 18,),2.kW,
                    Text("Auction End in:",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                  ],
                ),
              Text("1h 56m 20s",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500))],
            ),
            10.kH,
            LinearProgressBar(
              maxSteps: 6,
              progressType: LinearProgressBar.progressTypeLinear,
              currentStep: 1,
              progressColor:  appColors.brownDarkText,
              backgroundColor: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            )
             ,
            // Stack(
            //   children: [
            //     Container(
            //       height: 10,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),color: Colors.black12 ),
            //     ),
            //     Positioned(
            //         child: Container(
            //           height: 10,width: MediaQuery.of(context).size.width*0.7,decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),gradient: AppConstants.customGradientForBar ),
            //         )
            //     )
            //   ],
            // ),

          ],
        ),
      ),
    ],
  );
}
Widget assurance (){
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Text("Quality Assurance",
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text("Quality Score",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
              Text("9.2/10",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green)),
            ],
          ),
        ],
      ),
      18.kH,
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconText("Authenticity Verified"),
              16.kH,
              IconText("Damage Protection"),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconText("Quality Inspected"),
              16.kH,
              IconText("Insured Shipping"),
            ],
          ),
        ],
      ),
    ],
  );
}
Widget inspectionReport(){
  return Column(crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Quality Inspection Report",
          style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold)),
      8.kH,
      reportRow("Craftsmanship", "Excellent"),
      reportRow("Material Grade", "Premium"),
      reportRow("Finish Quality", "Superior"),
      reportRow("Structural Integrity", "Perfect"),

    ],
  );
}