import 'package:bhk_employee/data/response/status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/map_geolocation/mapcontroller.dart';



class Dashboardcontroller extends GetxController {

  LocationController locationController = Get.put(LocationController());



  final List<Map<String, dynamic>> serviceItems = [
    {
      'image': 'assets/images/ArticianImage1.jpg',
      'name': 'Wall Decorative',
      'category': 'Wall Decor',
      'price': 1200,
      'quality': 'Premium',
    },
    {
      'image': 'assets/images/ArticianImage8.jpg',
      'name': 'Clay Vase',
      'category': 'Clay Art',
      'price': 850,
      'quality': 'High',
    },
    {
      'image': 'assets/images/ArticianImage3.jpg',
      'name': 'Embroidered Cushion',
      'category': 'Textile Art',
      'price': 650,
      'quality': 'Premium',
    },
    {
      'image': 'assets/images/ArticianImage4.jpg',
      'name': 'Wooden Stool',
      'category': 'Woodcraft',
      'price': 1800,
      'quality': 'Standard',
    },
    {
      'image': 'assets/images/Product1.png',
      'name': 'Handwoven Carpet',
      'category': 'Handloom',
      'price': 3200,
      'quality': 'Luxury',
    },
  ];
  final List<Map<String, dynamic>> artisansItem = [
    {
      'image': 'assets/images/Profile.png',
      'name': 'Rajesh Gupta',
      'phoneNo': "+91 9876543210",
      'category': 'Wall Decorative',
    },
    {
      'image': 'assets/images/Profile.png',
      'name': 'Sunita Mishra',
      'phoneNo': "+91 8765432109",
      'category': 'Pottery',
    },
    {
      'image': 'assets/images/Profile.png',
      'name': 'Sita Verma',
      'phoneNo': "+91 7654321098",
      'category': 'Wood worker',
    },
    {
      'image': 'assets/images/Profile.png',
      'name': 'Ramesh Kumar',
      'phoneNo': "+91 9876501234",
      'category': 'Textile and Fabric',
    },
    {
      'image': 'assets/images/Profile.png',
      'name': 'Amitabh Sen',
      'phoneNo': "+91 9123456780",
      'category': 'Glass worker',
    },
  ];

  final List<Map<String, dynamic>> artisansDetailItem = [
    {
      "name": "Ramesh Kumar",
      "image": "assets/images/ramesh.png",
      "domain": "Handloom Textiles",
      "id": "ART12345",
      "phone": "+91 876543210",
      "status": "Available",
      "acceptanceStatus": "Approved",
      "noOfproduct": "15",
      "skills": ["Weaving", "Dyeing", "Embroidery"]
    },
    {
      "name": "Sita Verma",
      "image": "assets/images/sita.png",
      "domain": "Handloom Textiles",
      "id": "ART12346",
      "phone": "+91 876542109",
      "status": "Inactive",
      "acceptanceStatus": "Pending",
      "noOfproduct": "10",
      "skills": ["Embroidery", "Weaving", "Dyeing", "Embroidery","Packaging" ]
    },
    {
      "name": "Amitabh Sen",
      "image": "assets/images/amitabh.png",
      "domain": "Handloom Textiles",
      "id": "ART12347",
      "phone": "+91 765432109",
      "status": "Inactive",
      "acceptanceStatus": "Rejected",
      "noOfproduct": "24",
      "skills": ["Weaving", "Dyeing", "Embroidery", "Packaging"]
    },
    {
      "name": "Sunita Mishra",
      "image": "assets/images/sunita.png",
      "domain": "Handloom Textiles",
      "id": "ART12348",
      "phone": "+91 9876543210",
      "status": "Inactive",
      "acceptanceStatus": "Pending",
      "noOfproduct": "20",
      "skills": ["Embroidery", "Weaving", "Dyeing", "Embroidery","Handloom"]
    },
    {
      "name": "Arjun Mehta",
      "image": "assets/images/arjun.png",
      "domain": "Wooden Crafts",
      "id": "ART12349",
      "phone": "+91 9988776655",
      "status": "Available",
      "acceptanceStatus": "Approved",
      "noOfproduct": "21",
      "skills": ["Wood Carving", "Polishing"]
    },
    {
      "name": "Priya Verma",
      "image": "assets/images/priya.png",
      "domain": "Textile Design",
      "id": "ART12350",
      "phone": "+91 8877665544",
      "status": "Inactive",
      "acceptanceStatus": "Approved",
      "noOfproduct": "202",
      "skills": ["Weaving", "Printing", "Dyeing","Weaving", "Dyeing", "Embroidery"]
    },
    {
      "name": "Ravi Sharma",
      "image": "assets/images/ravi.png",
      "domain": "Pottery",
      "id": "ART12351",
      "phone": "+91 7766554433",
      "status": "Inactive",
      "acceptanceStatus": "Rejected",
      "noOfproduct": "222",
      "skills": ["Clay Modeling", "Painting"]
    },
    {
      "name": "Akash Gupta",
      "image": "assets/images/meena.png",
      "domain": "Handloom Textiles",
      "id": "ART12352",
      "phone": "+91 6655443322",
      "status": "Available",
      "acceptanceStatus": "Pending",
      "noOfproduct": "183",
      "skills": ["Embroidery", "Stitching"]
    },
    {
      "name": "Karan Patel",
      "image": "assets/images/karan.png",
      "domain": "Metal Crafts",
      "id": "ART12353",
      "phone": "+91 5544332211",
      "status": "Available",
      "acceptanceStatus": "Approved",
      "noOfproduct": "39",
      "skills": ["Casting", "Polishing", "Engraving"]
    },
    {
      "name": "Anjali Desai",
      "image": "assets/images/anjali.png",
      "domain": "Handloom Textiles",
      "id": "ART12354",
      "phone": "+91 4433221100",
      "status": "Inactive",
      "acceptanceStatus": "Rejected",
      "noOfproduct": "11",
      "skills": ["Weaving", "Embroidery"]
    }
  ];




  void setError(String value) => error.value = value;
  RxString error = ''.obs;

  var isLoading = false.obs;
  final rxRequestStatus = Status.COMPLETED.obs;



  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();

  }

  Future<void> dashboardRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    print("items.length");
    locationController.getCurrentLocation();}
}

var favoriteItems = <String, bool>{}.obs;

void toggleFavorite(String id) {
  favoriteItems[id] = !(favoriteItems[id] ?? false);
}

bool isFavorite(String id) {
  return favoriteItems[id] ?? false;
}
