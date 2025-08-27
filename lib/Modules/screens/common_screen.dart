import 'package:bhk_employee/Modules/controller/commondashcontroller.dart';
import 'package:bhk_employee/main.dart';
import 'package:bhk_employee/resources/colors.dart';
import 'package:bhk_employee/resources/font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/common_back.dart';

class CommonScreen extends ParentWidget {
  const CommonScreen({super.key});

  @override
  Widget buildingView(BuildContext context, double h, double w) {
    CommonDashController controller = Get.put(CommonDashController());
    return onBack(controller.pages[controller.selectedIndex.value], canPop: controller.selectedIndex.value == 0, (didPop, result) async {
      if (!didPop) {
        controller.selectedIndex.value = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CommonDashController controller = Get.put(CommonDashController());
    return Obx(
          () => Scaffold(
        body: super.build(context),
        bottomNavigationBar: Container(height: 75,
          decoration: BoxDecoration(color: appColors.backgroundColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4, offset: const Offset(0, -2))],),
          child: ClipRRect(
            borderRadius:  BorderRadius.vertical(top: Radius.circular(30)),
            child: Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent, highlightColor:Colors.transparent, hoverColor: Colors.transparent, splashFactory: NoSplash.splashFactory),
              child: BottomNavigationBar(
                backgroundColor: appColors.backgroundColor,
                items: controller.bottomNavigationItems,
                currentIndex: controller.changeIndex(),
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(fontSize: 12, color: appColors.contentBrown, fontFamily: appFonts.NunitoBold),
                iconSize: 28,
                selectedIconTheme: IconThemeData(size: 28, color: appColors.contentBrown),
                unselectedLabelStyle: TextStyle(fontSize: 12, fontFamily: appFonts.NunitoRegular, color: appColors.buttonTextStateDisabled),
                selectedItemColor: appColors.contentBrown,
                onTap: (index) => controller.selectedIndex.value = index,
                elevation: 0.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}