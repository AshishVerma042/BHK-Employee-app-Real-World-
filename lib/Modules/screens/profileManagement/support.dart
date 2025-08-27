import 'package:bhk_employee/common/common_widgets.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../resources/appconstants.dart';
import '../../../resources/colors.dart';
import '../../controller/supportcontroller.dart';

class Support extends ParentWidget {
  const Support({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    final controller = Get.put(SupportController());
    return Scaffold(
      backgroundColor: appColors.backgroundColor,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppConstants.customGradient,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Support",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset('assets/images/support.png', width: 400,),),
            commonComponent("Name",commonTextField(controller.nameController.value, controller.nameFocusNode.value, w, (value){},hint: "Enter your Name",fontSize: 14),
            ),
            12.kH,
            commonComponent("Email",commonTextField(controller.emailController.value, controller.nameFocusNode.value, w, (value){},hint: "Enter your Email",fontSize: 14),
            ),
            12.kH,
            commonComponent("Phone Number", commonTextField(controller.phoneController.value, controller.nameFocusNode.value, w, (value){},hint: "Enter your Phone number",fontSize: 14),
            ),
            12.kH,
            commonComponent("Message",commonTextField(controller.messageController.value, controller.nameFocusNode.value, w,maxLines: 4, (value){},hint: "Enter your messages",fontSize: 15),
            ),
            20.kH,
            commonButton(w, 50, appColors.contentButtonBrown, Colors.white, (){},hint: "Send message"),
            SizedBox(height: 30,),
            contactDetails(Icons.call,"(246)264 845"),
            contactDetails(Icons.email_outlined,"BharathasthKaushal@gmail.com"),
          
          ],
        ),
      ),
    );
  }
}


Widget contactDetails(IconData icon, String details){
  return Row(mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Icon( icon,size: 23,),
      SizedBox(width: 6,),
      Text(details,style: TextStyle(fontSize: 18),)
    ],);
}
