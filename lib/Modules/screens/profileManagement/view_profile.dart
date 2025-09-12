
import 'package:bhk_employee/resources/appconstants.dart';
import 'package:bhk_employee/resources/images.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/profilecontroller.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return Container(
      color:  Color.fromARGB(195, 247, 243, 233),
      child: Scaffold(
        backgroundColor:  Color.fromARGB(255, 247, 243, 233),
        appBar: AppBar(
          flexibleSpace: Container(
            decoration:  BoxDecoration(
              gradient: AppConstants.customGradient,
            ),
          ),
          iconTheme:  IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            appStrings.viewProfile.toUpperCase(),
            style:  TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 30.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor:  Color.fromARGB(195, 250, 248, 238),
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

                40.kH,

                Padding(
                  padding:  EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                       Icon(Icons.edit_document, size: 20.0, color: Colors.blue),
                       SizedBox(width: 8.0),
                      Text(
                        appStrings.personalInformation,
                        style:  TextStyle(
                            fontSize: 17.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),

                20.kH,


                ListTile(
                  leading: const Icon(Icons.person_outline, color: Colors.black),
                  title: Text(appStrings.firstName, style: const TextStyle(color: Colors.grey)),
                  subtitle: Text(
                      appStrings.pleaseSetYourFirstName,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline, color: Colors.black),
                  title: Text(appStrings.lastName, style: const TextStyle(color: Colors.grey)),
                  subtitle: Text(
                    appStrings.pleaseSetYourLastName,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),


                ListTile(
                  leading:  Icon(Icons.phone_outlined, color: Colors.black),
                  title: Text(appStrings.phoneNumber, style:  TextStyle(color: Colors.grey)),
                  subtitle: Text(
                    "${controller.getProfileModel.value.data?.countryCode??""} ${controller.getProfileModel.value.data?.phoneNo??"Please set your Phone number"}" ,
                    style:  TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),

                ListTile(
                  leading:  Icon(Icons.email_outlined, color: Colors.black),
                  title: Text(appStrings.email, style: const TextStyle(color: Colors.grey)),
                  subtitle: Text(
                      appStrings.pleaseSetYourEmail,
                    style:  TextStyle(fontSize: 16, color: Colors.black),
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
