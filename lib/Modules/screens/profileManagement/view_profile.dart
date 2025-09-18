import 'package:bhk_employee/resources/appconstants.dart';
import 'package:bhk_employee/resources/images.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../resources/colors.dart';
import '../../controller/profilecontroller.dart';


class ViewProfile extends StatelessWidget {
  const ViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration:  BoxDecoration(
            gradient: AppConstants.customGradient,
          ),
        ),
        iconTheme:  IconThemeData(color: Colors.white),
        title:  Text(
          appStrings.profile.toUpperCase(),
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(top: 30.0), child: circularAvtar(controller)),
                40.kH,
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Icon(Icons.edit_document, size: 20.0, color: Colors.blue),
                      8.kW,
                      Text(appStrings.personalInformation, style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                20.kH,
                listData(Icons.person_outline, appStrings.firstName, appStrings.pleaseSetYourFirstName),

                listData(Icons.person_outline, appStrings.lastName, appStrings.pleaseSetYourLastName),

                listData(Icons.phone_outlined, appStrings.phoneNumber, "${controller.getProfileModel.value.data?.countryCode ?? ""} ${controller.getProfileModel.value.data?.phoneNo ?? "Please set your Phone number"}"),

                listData(Icons.email_outlined, appStrings.email, appStrings.pleaseSetYourEmail),
              ],
            ),
          ),
        ),
    );
  }
}

Widget listData(IconData icon, String text, String subTitle) {
  return ListTile(
    leading: Icon(icon, color: Colors.black),
    title: Text(text, style: TextStyle(color: Colors.grey)),
    subtitle: Text(subTitle, style: TextStyle(fontSize: 16, color: Colors.black)),
  );
}

Widget circularAvtar(ProfileController controller) {
  return CircleAvatar(backgroundColor: Color.fromARGB(195, 250, 248, 238), radius: 70.0, backgroundImage: controller.getProfileModel.value.data?.avatar?.isNotEmpty ?? false ? NetworkImage(controller.getProfileModel.value.data?.avatar ?? "") : AssetImage(AppImages.profile));
}
