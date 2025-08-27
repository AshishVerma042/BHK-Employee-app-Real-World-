
import 'package:bhk_employee/resources/appconstants.dart';
import 'package:bhk_employee/resources/images.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profilecontroller.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return Container(
      color: const Color.fromARGB(195, 247, 243, 233),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 247, 243, 233),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: AppConstants.customGradient,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            appStrings.viewProfile.toUpperCase(),
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color.fromARGB(195, 250, 248, 238),
                        radius: 70.0,
                        backgroundImage: controller.getProfileModel
                            .value.data?.avatar?.isNotEmpty ??
                            false
                            ? NetworkImage(
                            controller.getProfileModel.value.data
                                ?.avatar ??
                                "")
                            : AssetImage(
                          AppImages.profile,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      const Icon(Icons.edit_document, size: 20.0, color: Colors.blue),
                      const SizedBox(width: 8.0),
                      Text(
                        appStrings.personalInformation,
                        style: const TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),


                ListTile(
                  leading: const Icon(Icons.person_outline, color: Colors.black),
                  title: Text("First Name", style: const TextStyle(color: Colors.grey)),
                  subtitle: Text(
                      "Please set your First name",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline, color: Colors.black),
                  title: Text("Last Name", style: const TextStyle(color: Colors.grey)),
                  subtitle: Text(
                    "Please set your Last name",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),


                ListTile(
                  leading: const Icon(Icons.phone_outlined, color: Colors.black),
                  title: Text(appStrings.phoneNumber, style: const TextStyle(color: Colors.grey)),
                  subtitle: Text(
                    "${controller.getProfileModel.value.data?.countryCode??""} ${controller.getProfileModel.value.data?.phoneNo??"Please set your Phone number"}" ,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.email_outlined, color: Colors.black),
                  title: Text(appStrings.email, style: const TextStyle(color: Colors.grey)),
                  subtitle: Text(
                      "Please set your Email ",
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
