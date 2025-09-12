import 'package:bhk_employee/resources/colors.dart';
import 'package:bhk_employee/resources/strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Visibility progressBarTransparentAnimationLoader(value, h, w) {
  return Visibility(
    visible: value,
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.6),
            ],
          )),
      child:  Center(
        child: LoadingAnimationWidget.hexagonDots(
          color: appColors.brownDarkText,
          size: 70,
        ),
      ),
    ),
  );
}

Visibility progressBarTransparent(value, h, w) {
  return Visibility(
    visible: value,
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.black.withOpacity(0.6),
          Colors.black.withOpacity(0.8),
        ],
      )),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Colors.transparent,
        ),
      ),
    ),
  );
}

Visibility progressBarTransparentWithOpacity(value, h, w) {
  return Visibility(
    visible: value,
    child: Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: Colors.black,
          backgroundColor: Colors.transparent,
        ),
      ),
    ),
  );
}
//
// Visibility internetException(value, onPress) {
//   return Visibility(
//       visible: value,
//       child: InternetExceptionWidget(
//         onPress: onPress,
//       ));
// }
//
// Visibility generalException(value, onPress) {
//   return Visibility(
//       visible: value,
//       child: GeneralExceptionWidget(
//         onPress: onPress,
//       ));
// }
//
// Visibility authentication(value) {
//   return Visibility(visible: value, child: AuthenticationExceptionWidget());
// }
