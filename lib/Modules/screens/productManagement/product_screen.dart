// import 'package:bhk_employee/Modules/controller/getproductcontroller.dart';
// import 'package:bhk_employee/main.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../resources/appconstants.dart';
// import '../../../resources/colors.dart';
//
// class ProductScreen extends ParentWidget {
//   const ProductScreen({super.key});
//
//   @override
//   Widget buildingView(BuildContext context, double h, double w) {
//     GetProductController controller = Get.put(GetProductController());
//
//     return Stack(
//       children: [
//         Scaffold(
//           appBar: topAppBar(),
//           backgroundColor: appColors.backgroundColor,
//           body: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
//               child: GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: controller.serviceItems.length,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.85),
//                 itemBuilder: (context, index) {
//                   return myProductCard(controller.serviceItems[index]);
//                 },
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// PreferredSizeWidget topAppBar() {
//   return AppBar(
//     flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppConstants.customGradient)),
//     elevation: 0,
//     automaticallyImplyLeading: true,
//     title: Text(
//       'Product',
//       style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
//     ),
//     centerTitle: true,
//     iconTheme: const IconThemeData(color: Colors.white),
//   );
// }
//
// Widget myProductCard(Map<String, dynamic> item) {
//   return Container(
//     width: double.infinity,
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.grey.shade300),
//       borderRadius: BorderRadius.circular(16),
//       color: Colors.white,
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       // mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         ClipRRect(
//           borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
//           child: Image.asset(item['image'], width: double.infinity, height: 140, fit: BoxFit.cover),
//         ),
//
//         // Details Section
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(item['category'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
//                   Row(
//                     children: [
//                       const Icon(Icons.star, size: 14, color: Colors.orange),
//                       const SizedBox(width: 4),
//                       Text(item['quality'], style: const TextStyle(fontSize: 12)),
//                     ],
//                   ),
//                 ],
//               ),
//
//               Text(
//                 item['name'],
//                 style: TextStyle(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w600),
//               ),
//
//               Text(
//                 "₹${item['price']}",
//                 style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }