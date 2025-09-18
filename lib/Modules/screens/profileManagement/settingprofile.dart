
import 'package:bhk_employee/resources/strings.dart';
import 'package:bhk_employee/routes/RoutesClass.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_profile.dart';

class SettingProfile extends StatelessWidget {
  const SettingProfile({super.key});

  profile(int index) {
    print(index);
    switch (index) {
      case 1:
        Get.toNamed(RoutesClass.gotoChangePasswordScreen());
        break;

      case 2:
        Get.toNamed(RoutesClass.gotoEditProfileScreen());
        break;
      case 3:
        Get.toNamed(RoutesClass.gotoOrderScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 243, 233),
      appBar:topAppBar(appStrings.settings),
      body: Container(
        color:  Color.fromARGB(195, 250, 248, 242),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.fromLTRB(20, 5, 20, 20),
            child: Column(
              children: [
                buildProfileOptionCard(appStrings.editProfile,
                    appStrings.editOrChangeYourProfile, Icons.edit, 2),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProfileOptionCard(
      String title, String subtitle, IconData icon, int index) {
    return Column(
      children: [
        ListTile(
          contentPadding:  EdgeInsets.symmetric(horizontal: 15),
          leading: Icon(icon, color: Colors.brown[700]),
          title:
              Text(title, style:  TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle,
              style:  TextStyle(fontSize: 12, color: Colors.grey)),
          trailing:  Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: () {
            profile(index);
          },
        ),
         Divider(
          height: 5,
          thickness: 0.25,
          endIndent: 0,
          color: Colors.black,
        ),
      ],
    );
  }
}
