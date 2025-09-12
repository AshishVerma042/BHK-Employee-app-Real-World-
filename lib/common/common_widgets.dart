import 'dart:convert';
import 'dart:io';

import 'package:bhk_employee/common/gradient.dart';
import 'package:bhk_employee/utils/sized_box_extension.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Constants/utils.dart';
import '../Modules/screens/artisanManagement/product_detail_page.dart';
import '../data/response/status.dart';
import '../resources/colors.dart';
import '../resources/font.dart';
import '../resources/strings.dart';
import '../routes/RoutesClass.dart';
import 'CommonMethods.dart';

PreferredSizeWidget commonAppBar(String title) {
  return AppBar(
    flexibleSpace: Container(decoration: const BoxDecoration(gradient: AppGradients.customGradient)),
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: true,
    title: Text(title.toUpperCase(), style: const TextStyle(fontSize: 16, color: Colors.white)),
  );
}





Widget commonSumbitButton( String label){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromARGB(255, 155, 105, 89),
      minimumSize: const Size(double.infinity, 50),
    ),
    onPressed: () {},
    child: Text(label, style: TextStyle(color: Colors.white, fontSize: 16),),
  );
}
Widget innerPhoneTextField(
    TextEditingController controller,
    FocusNode focusNode,
    double width,
    double height, {
      FormFieldValidator<String>? validator,
      var error,
      int maxLength = 15,
      String hint = '',
      bool enabled = true,
      bool obscure = false,
      String initialValue = "IN",
      TextInputType keyboardType = TextInputType.phone,
      void Function(String)? onChange,
      bool isWhite = false,
      void Function(Country)? onCountryChanged,
      ValueChanged<PhoneNumber>? onCountryCodeChange,
      List<TextInputFormatter>? inputFormatters,
    }) {
  return StatefulBuilder(
    builder: (context, setState) {
      return IntlPhoneField(
        focusNode: focusNode,
        controller: controller,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: hint,
          labelStyle:  TextStyle(color: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,fontSize: 16),
          error: null,
          errorStyle: TextStyle(color: Colors.transparent),
          counterStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:  BorderSide(color:  isWhite ? Colors.white : appColors.border, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide:  BorderSide(color:  isWhite ? Colors.white : appColors.contentPlaceholderPrimary, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        ),
        style:  TextStyle( color: Colors.black ),
        dropdownTextStyle:  TextStyle(color: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,fontSize: 16),
        cursorColor:  isWhite ? Colors.white : appColors.contentPlaceholderPrimary,
        dropdownIcon: Icon(Icons.arrow_drop_down, color:isWhite ? Colors.white : appColors.contentPlaceholderPrimary),
        initialCountryCode: initialValue,
        languageCode: "en",
        onChanged: onCountryCodeChange,
        onCountryChanged: onCountryChanged,
      );
    },
  );
}
Widget commonLocation({void Function(String)? onCountryChanged, ValueChanged<String?>? onStateChanged, ValueChanged<String?>? onCityChanged, double radius = 25, double height = 1.8}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return CSCPicker(
        defaultCountry: CscCountry.India,
        showStates: true,
        showCities: true,
        layout: Layout.vertical,
        flagState: CountryFlag.DISABLE,
        dropdownDecoration: BoxDecoration(
          border: Border.all(color: appColors.border, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        disabledDropdownDecoration: BoxDecoration(
          border: Border.all(color: appColors.border, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        selectedItemStyle: TextStyle(color: appColors.contentPrimary, fontSize: 14, height: height),
        dropdownHeadingStyle: TextStyle(color: appColors.contentPending, fontSize: 20, fontFamily: appFonts.robotoSlabBold, fontWeight: FontWeight.bold),
        dropdownItemStyle: TextStyle(color: appColors.contentPending, fontSize: 16),
        dropdownDialogRadius: radius,
        searchBarRadius: radius,
        onCountryChanged: onCountryChanged,
        onStateChanged: onStateChanged,
        onCityChanged: onCityChanged,
      );
    },
  );
}

Widget commonTextField(
    TextEditingController controller,
    FocusNode focusNode,
    double width,
    void Function(String) onSubmitted, {
      bool isWhite = false,
      int maxLength = 254,
      double contentPadding = 12,
      String hint = '',
      String label = '',
      dynamic error,
      dynamic maxLines = 1,
      bool readonly = false,
      bool isCounter = false,
      void Function(String)? onChange,
      double radius = 8,
      double borderWidth = 1,
      String prefix ="",
      String suffix ="",
      double fontSize = 12,
      TextInputType keyboardType = TextInputType.text,
      TextInputAction textInputAction = TextInputAction.done,
      List<TextInputFormatter>? inputFormatters,
      bool alwaysHint = false,
    }) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onSubmitted: onSubmitted,
        readOnly: readonly,
        onTapOutside: (value) => focusNode.unfocus(),
        onChanged: onChange,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        cursorColor: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,
        style: TextStyle(color: isWhite ? Colors.white : appColors.contentPrimary),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: alwaysHint ? hint : null,
          labelText: hint,
          prefixText: prefix,
          suffixText: suffix,
          labelStyle: TextStyle(color: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,fontSize: fontSize),
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width:borderWidth),
          ),
          counterText: isCounter?null:"",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width:borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:  BorderSide(color: Colors.red, width:borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:  BorderSide(color: Colors.red, width:borderWidth),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: contentPadding),
        ),
      );
    },
  );
}

Widget commonDescriptionTextField(
    TextEditingController controller,
    FocusNode focusNode,
    double width,
    void Function(String) onSubmitted, {
      bool isWhite = false,
      double contentPadding = 12,
      String hint = '',
      dynamic error,
      maxLines = 1,
      minLines = 1,
      dynamic maxLength = 1000,
      bool readonly = false,
      double radius = 8,
      double borderWidth = 1,
      double fontSize = 12,
      void Function(String)? onChange,
      TextInputType keyboardType = TextInputType.multiline,
      TextInputAction textInputAction = TextInputAction.newline,
      List<TextInputFormatter>? inputFormatters,
    }) {
  return StatefulBuilder(
    builder: (context, setState) {
      int maxLinesCalc = focusNode.hasFocus ? minLines : maxLines;
      focusNode.addListener(() {
        setState(() {});
      });
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        readOnly: readonly,
        onTapOutside: (value) => focusNode.unfocus(),
        onChanged: onChange,
        maxLines: maxLinesCalc,
        textAlign: TextAlign.start,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        cursorColor: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,
        style: TextStyle(color: isWhite ? Colors.white : appColors.contentPrimary),
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: TextStyle(color: isWhite ? Colors.white : appColors.contentPlaceholderPrimary,fontSize: fontSize),
          alignLabelWithHint: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width:borderWidth),
          ),
          counterText: "",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: isWhite ? Colors.white : appColors.border, width:borderWidth),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:  BorderSide(color: Colors.red, width:borderWidth),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide:  BorderSide(color: Colors.red, width:borderWidth),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: contentPadding),
        ),
      );
    },
  );
}

Widget commonDropdownButton(List<DropdownMenuItem<String>>? items, String? selectedValue, double width, double height, Color color, void Function(String?) onChanged, {String hint = '', Color borderColor = Colors.transparent}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      border: Border.all(color: borderColor, width: 1.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: DropdownButton2<String>(
      hint: Text(hint),
      style: TextStyle(fontSize: 14, color: Colors.black),
      value: selectedValue,
      items: items,
      onChanged: onChanged,
      dropdownStyleData: DropdownStyleData(
        maxHeight: height * .25,
        width: width * .918,
        offset: const Offset(-9, -3),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.white),
      ),
      isExpanded: true,
      underline: const SizedBox(),
    ),
  );
}

Widget passwordField(TextEditingController controller, FocusNode focusNode, double width, VoidCallback onTap, void Function(String) onSubmitted, {int maxLength = 320, double contentPadding = 12, String hint = '', dynamic error, bool obscure = false, void Function(String)? onChange, List<TextInputFormatter>? inputFormatters}) {
  return StatefulBuilder(
    builder: (context, setState) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxLength,
        onTapOutside: (value) => focusNode.unfocus(),
        onSubmitted: onSubmitted,
        inputFormatters: inputFormatters,
        onChanged: onChange,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: Icon(obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded, size: 22, color: appColors.contentPrimary),
            ),
          ),
          contentPadding: EdgeInsets.all(contentPadding),
          isDense: true,
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 12),
          border: const OutlineInputBorder(borderSide: BorderSide(width: 2.0), borderRadius: BorderRadius.all(Radius.circular(8.0))),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0), // Customize focused border
          ),
          counterText: "",
          errorText: error,
          errorMaxLines: 2,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0), // Customize focused border
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(82, 151, 92, 71), width: 2.0), // Customize focused border
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: appColors.contentAccent, // Red border for errors
              width: 2.0,
            ),
          ),
        ),
        maxLines: 1,
        textAlign: TextAlign.start,
        obscureText: obscure,
        style: TextStyle(color: appColors.contentPrimary, fontSize: 16, fontFamily: appFonts.NunitoRegular, fontWeight: FontWeight.w600),
      );
    },
  );
}

Widget phoneTextField(
    TextEditingController controller,
    FocusNode focusNode,
    double width,
    double height, {
      FormFieldValidator<String>? validator,
      var error,
      int maxLength = 15,
      String hint = '',
      bool enabled = true,
      bool obscure = false,
      String initialValue = "IN",
      TextInputType keyboardType = TextInputType.phone,
      void Function(String)? onChange,
      void Function(Country)? onCountryChanged,
      ValueChanged<PhoneNumber>? onCountryCodeChange,
      List<TextInputFormatter>? inputFormatters,
    }) {
  return StatefulBuilder(
    builder: (context, setState) {
      return IntlPhoneField(
        focusNode: focusNode,
        controller: controller,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: hint,
          labelStyle: const TextStyle(color: Colors.white),
          error: null,
          errorStyle: TextStyle(color: Colors.transparent),
          counterStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        ),
        style: const TextStyle(color: Colors.white),
        dropdownTextStyle: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        dropdownIcon: const Icon(Icons.arrow_drop_down, color: Colors.transparent),
        initialCountryCode: initialValue,
        languageCode: "en",
        onChanged: onCountryCodeChange,
        onCountryChanged: onCountryChanged,
      );
    },
  );
}



Widget checkBox(bool value, double scale, double radius, double border, Color selectedColor, Color selectedFillColor, Color fillColor, Color borderColor, ValueChanged<bool?> onChanged) {
  return Transform.scale(
    scale: scale,
    child: Checkbox(
      value: value,
      onChanged: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius), // Set border radius
      ),
      side: WidgetStateBorderSide.resolveWith(
            (states) => BorderSide(
          color: states.contains(WidgetState.selected) ? borderColor : borderColor,
          width: border, // Border width
        ),
      ),
      fillColor: WidgetStateProperty.resolveWith((states) => states.contains(WidgetState.selected) ? selectedFillColor : fillColor),
      checkColor: selectedColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    ),
  );
}

Widget commonButton(double width, double height, Color backgroundColor, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, double paddingVertical = 0, double paddingHorizontal = 0, double fontSize = 16, Color borderColor = Colors.transparent}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
      minimumSize: Size(width, height),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Text(
      hint,
      style: TextStyle(fontSize: fontSize, fontFamily: appFonts.NunitoBold, fontWeight: FontWeight.w500, color: color),
    ),
  );
}

Widget bottomText() {
  return Padding(
    padding: EdgeInsets.only(left: 25, bottom: 50, right: 25),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: Colors.white, fontSize: 13),
        children: [
          TextSpan(text: 'By continuing, you agree to our '),
          TextSpan(
            text: 'Privacy Policy\n',
            style: TextStyle(color: appColors.contentAccent),
            // Add gesture recognizer if needed
          ),
          TextSpan(text: ' and '),
          TextSpan(
            text: 'Terms of Service',
            style: TextStyle(color: appColors.contentAccent),
            // Add gesture recognizer if needed
          ),
          TextSpan(text: '.'),
        ],
      ),
    ),
  );
}

Widget commonButtonWithLoader(double width, double height, Color backgroundColor, Color color, Rx<bool> isLoading, VoidCallback? onChanged, {String hint = '', double radius = 12, double paddingVertical = 0, double paddingHorizontal = 0, double fontSize = 16, Color borderColor = Colors.transparent}) {
  return Obx(
        () => ElevatedButton(
      onPressed: isLoading.value ? null : onChanged, // Disable when loading
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: paddingHorizontal),
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: borderColor, width: 1),
        ),
      ),
      child: isLoading.value
          ? SizedBox(
        width: fontSize,
        height: fontSize,
        child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(color)),
      )
          : Text(
        hint,
        style: TextStyle(fontSize: fontSize, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
      ),
    ),
  );
}

Widget commonButtonWithoutWidth(Color backgroundColor, Color color, VoidCallback? onChanged, {Color borderColor = Colors.transparent, bool bold = false, double fontSize = 16, double paddingV = 0.0, double paddingH = 4.0, String hint = '', double radius = 12}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(0, 33),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingH,vertical: paddingV),
      child: Text(
        hint,
        style: TextStyle(fontSize: fontSize, fontFamily: bold ? appFonts.NunitoBold : appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
      ),
    ),
  );
}

Widget commonButtonShadow(double width, double height, Color borderColor, Color backgroundColor, Color color, VoidCallback? onChanged, {String hint = '', double radius = 12}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [BoxShadow(color: appColors.contentAccent.withOpacity(0.5), spreadRadius: 0, blurRadius: 10, offset: const Offset(0, 4))],
    ),
    child: ElevatedButton(
      onPressed: onChanged,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
        minimumSize: Size(width, height),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor, width: 1),
        ),
        shadowColor: Colors.transparent,
      ),
      child: Text(
        hint,
        style: TextStyle(
          fontSize: 16,
          fontFamily: appFonts.NunitoMedium,
          fontWeight: FontWeight.w600,
          color: color, // Text color
        ),
      ),
    ),
  );
}

Widget commonButtonIcon(double width, double height,  Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, IconData icon = Icons.arrow_forward, bool forward = true, Color borderColor = Colors.transparent,Color backgroundColor = Colors.transparent}) {
  return ElevatedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      minimumSize: Size(width, height),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        forward
            ? Text(
          hint,
          style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
        )
            : Icon(icon, color: color, size: 18),
        4.kW,
        forward
            ? Icon(icon, color: color, size: 18)
            : Text(
          hint,
          style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
        ),
      ],
    ),
  );
}

Widget commonOutlinedButtonIcon(double width, double height,  Color color, VoidCallback? onChanged, {String hint = '', double radius = 12, IconData icon = Icons.arrow_forward, bool forward = true, Color borderColor = Colors.transparent, Color overlayColor = Colors.brown}) {
  return OutlinedButton(
    onPressed: onChanged,
    style: ElevatedButton.styleFrom(
      minimumSize: Size(width, height),
      overlayColor: overlayColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(color: borderColor, width: 1),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        forward
            ? Text(
          hint,
          style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
        )
            : Icon(icon, color: color, size: 18),
        4.kW,
        forward
            ? Icon(icon, color: color, size: 18)
            : Text(
          hint,
          style: TextStyle(fontSize: 16, fontFamily: appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
        ),
      ],
    ),
  );
}

Widget commonColorTags(Color backgroundColor, Color color, {Color borderColor = Colors.transparent, bool bold = false, double fontSize = 16, double padding = 4.0, double vPadding = 0.0, String hint = '', double radius = 12}) {
  return Container(
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor, width: 1),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: vPadding),
      child: Text(
        hint,
        style: TextStyle(fontSize: fontSize, fontFamily: bold ? appFonts.NunitoBold : appFonts.NunitoMedium, fontWeight: FontWeight.w600, color: color),
      ),
    ),
  );
}

Widget radioButtonObjective(String value, Rx<String> selectedValue, Color selectedColor, Color textColor, String hint, VoidCallback? onTap, {double borderRadius = 12}) {
  return Obx(
        () => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: selectedValue.value == value ? appColors.contentAccent : appColors.buttonStateDisabled, width: 2),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(selectedValue.value == value ? Icons.check_circle : Icons.circle_outlined, color: selectedValue.value == value ? selectedColor : textColor, size: 25),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                textAlign: TextAlign.start,
                hint,
                style: TextStyle(fontSize: 16, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget checkButtonObjective(
    int index,
    RxList<bool> selectedList,
    Color selectedColor,
    Color textColor,
    String hint,
    VoidCallback? onTap, {
      double borderRadius = 12, // outer container border radius
    }) {
  return Obx(
        () => GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: selectedList[index] ? selectedColor : appColors.buttonStateDisabled, width: 2),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: selectedList[index] ? selectedColor : textColor, width: 2),
                color: selectedList[index] ? selectedColor : Colors.transparent,
              ),
              child: selectedList[index] ? const Icon(Icons.check, weight: 200, size: 16, color: Colors.white) : null,
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                hint,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, fontFamily: AppFonts.appFonts.NunitoBold, color: appColors.contentPrimary),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget otpField(BuildContext context, TextEditingController controller, length, void Function(String) onSubmitted, {double? fieldWidth, double? fieldHeight, double fontSize = 21, double borderRadius = 10, void Function(String)? onChanged , bool autoFocus = true, Color backgroundColor = Colors.grey}) {
  return PinCodeTextField(
    appContext: context,
    length: length,
    keyboardType: TextInputType.number,
    animationType: AnimationType.fade,
    autoFocus: autoFocus,
    cursorColor: appColors.contentPrimary,
    cursorHeight: fontSize,
    textStyle: TextStyle(fontSize: fontSize, color: appColors.contentPrimary, fontWeight: FontWeight.w800, fontFamily: appFonts.NunitoBold),
    controller: controller,
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(borderRadius),
      fieldHeight: fieldHeight ?? Get.height * 0.075,
      fieldWidth: fieldWidth ?? Get.width * 0.14,
      activeFillColor: backgroundColor.withValues(alpha: 0.9),
      selectedColor: appColors.border,
      activeColor: appColors.border,
      selectedFillColor: backgroundColor.withValues(alpha: 0.9),
      inactiveColor: appColors.border,
      inactiveFillColor: backgroundColor.withValues(alpha: 0.9),
    ),
    enableActiveFill: true,
    onChanged: onChanged,
    onCompleted: onSubmitted,
  );
}

Text titleText(String text, {double fontSize = 20.0, fontFamily = 'RobotsRegular', var color = Colors.black, var fontWeight = FontWeight.w600}) {
  return Text(
    text,
    style: TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: color, overflow: TextOverflow.ellipsis, fontWeight: fontWeight),
  );
}

Text descriptionText(String text, {double fontSize = 11.0, double height = 0, fontFamily = 'RobotsRegular', var color = Colors.black, textAlign = TextAlign.start, var fontWeight = FontWeight.bold, underLine = false}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(height: height, fontSize: fontSize, fontFamily: fontFamily, color: color, fontWeight: fontWeight, decoration: underLine ? TextDecoration.underline : TextDecoration.none),
  );
}

Widget commonComponent(String title, Widget component, {bool mandatory = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          if (mandatory) ...[
            Text(
              " *",
              style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
      5.kH,
      component,
    ],
  );
}

Widget commonComponentRedStar(String title, {bool mandatory = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
          if (mandatory) ...[
            Text(
              " *",
              style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ],
      ),
      5.kH,

    ],
  );
}

Widget productCard(Map<String, dynamic> list) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Image.asset(list['image']!, width: double.infinity, fit: BoxFit.cover),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text("${list['tag']!}", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              Text(
                list['name']!,
                style: TextStyle(fontSize: 12, color: appColors.contentPrimary, fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
              Text(
                "Number of Product : ${list['rating']!.toString()}",
                style: TextStyle(fontSize: 12, color: appColors.contentPrimary, fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
void handleApiError(dynamic error, dynamic stackTrace, {Function(String)? setError, Function(Status)? setRxRequestStatus, bool closeDialog = false,bool showMessage = false}) {
  if (closeDialog) {
    Get.back();
  }

  setError?.call(error.toString());
  setRxRequestStatus?.call(Status.ERROR);

  try {
    if (error.toString().contains("{")) {
      var errorResponse = json.decode(error.toString());

      if (errorResponse is Map && errorResponse.containsKey('message')) {
        if(showMessage) {
          CommonMethods.showToast(errorResponse['message']);
        }
      } else {
        //CommonMethods.showToast("An unexpected error occurred.");
      }
    } else {
      //CommonMethods.showToast(error.toString());
    }
  } catch (e) {
    //CommonMethods.showToast("An unexpected error occurred.");
  }

  Utils.printLog("Error===> ${error.toString()}");
  Utils.printLog("stackTrace===> ${stackTrace.toString()}");
}

Future<void> bottomDrawerMultiFile(
    BuildContext context,
    double height,
    double width,
    List<String> imageFiles,
    VoidCallback onCameraTap,
    VoidCallback onGalleryTap,
    ) async {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Select File Source",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text("Use Camera"),
              onTap: onCameraTap,
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text("Choose from Gallery"),
              onTap: onGalleryTap,
            ),
          ],
        ),
      );
    },
  );
}
Future<void> bottomDrawerVideoFile(
    BuildContext context,
    double height,
    double width,
    Rxn<File> imageFiles,
    VoidCallback onCameraTap,
    VoidCallback onGalleryTap,
    ) async {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (BuildContext context) {
      return Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Select File Source",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.blue),
              title: const Text("Use Camera"),
              onTap: onCameraTap,
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Colors.green),
              title: const Text("Choose from Gallery"),
              onTap: onGalleryTap,
            ),
          ],
        ),
      );
    },
  );
}

Future<void> pickMultipleImagesFromGallery(
    List<String> imageFiles,
    bool fromCamera,
    ) async {
  final ImagePicker picker = ImagePicker();

  if (fromCamera) {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      if (imageFiles.length < 10) {
        imageFiles.add(image.path);
      }
    }
  } else {
    final List<XFile> images = await picker.pickMultiImage();
    if (images.isNotEmpty) {
      for (var img in images) {
        if (imageFiles.length >= 10) break; // limit 10 images
        imageFiles.add(img.path);
      }
    }
  }
}
Future<void> pickVideoFromGallery(
    Rxn<File> videoFiles,
    bool fromCamera,
    ) async {
  final picker = ImagePicker();

  if (fromCamera) {
    final pickedVideo = await picker.pickVideo(
      source: ImageSource.camera,
      maxDuration: const Duration(seconds: 15),
    );
    if (pickedVideo != null) {
      videoFiles.value = File(pickedVideo.path);
    }
    Get.back();
  }
  else {
    final pickedVideo = await picker.pickVideo(
      source: ImageSource.gallery,
    );
    if (pickedVideo != null) {
      videoFiles.value = File(pickedVideo.path);
    }
    Get.back();
      }
    }


Widget myProductCard(Map<String, dynamic> item, {bool isFavorite = false}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage(item['image']), fit: BoxFit.cover),
      border: Border.all(color: Colors.grey.shade300),
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding:  EdgeInsets.all(6.0),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration:  BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                        bottomRight: Radius.circular(14),
                      ),
                    ),
                    child: Row(
                      children:  [
                        Icon(Icons.check, size: 16, color: Colors.white),
                        SizedBox(width: 2),
                        Text("verified",
                            style:
                            TextStyle(fontSize: 10, color: Colors.white)),
                        SizedBox(width: 2),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      isFavorite = !isFavorite;
                    },
                    child: Container(
                      padding:  EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding:  EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius:  BorderRadius.only(
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.6),
                blurRadius: 6,
              )
            ],
          ),
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 4, vertical: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item['name'],
                        style:  TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: Colors.grey, blurRadius: 5)
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.workspace_premium,
                        color: Colors.white70, size: 16),
                    Text(item['category'],
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70)),
                  ],
                ),
                Center(
                  child: commonButton(double.infinity, 35,
                      appColors.brownDarkText, Colors.white, () {Get.to(() => ProductDetailScreen(product: item));
                      },
                      hint: appStrings.preview, fontSize: 15, radius: 50),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


Widget artisanDetailCard(dynamic artisan,{

  VoidCallback? onTap,
  VoidCallback? onAddProduct,
}) {
  return InkWell(
    onTap: onTap,

    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: appColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    "assets/images/Profile.png",
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                12.kW,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              " ${artisan.firstName?? "Unknown"} ${artisan.lastName?? "Unknown"}",
                              style:  TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      4.kH,
                      Text(
                        "${artisan.expertizeField?? "Not Set"}",
                        style:  TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      6.kH,
                      Text(
                        "${appStrings.BHKEID} ${artisan.id?? 0000 }",
                        style:  TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                      6.kH,
                      Row(
                        children: [
                           Icon(Icons.phone, size: 14, color: Colors.black54),
                          4.kW,
                          Text(
                            "${artisan.countryCode?? "XX"} ${artisan.phoneNo?? "XXXXXXXXXX"}",
                            style:  TextStyle(fontSize: 13, color: Colors.black87),
                          ),
                        ],
                      ),
                      6.kH,
                      Text(
                        "${artisan.email?? "Not Set"}",
                        style:  TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ],
                  ),
                ),

                InkWell(
                  onTap: onAddProduct,
                  child: Container(padding: EdgeInsets.symmetric(vertical: 6,horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(Icons.add, color: Colors.brown, size: 19.0),
                        2.kW,
                        Text(
                          appStrings.addProduct,
                          style:  TextStyle(color: Colors.brown, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Wrap(
            //   spacing: 8,
            //   runSpacing: 4,
            //   children: List.generate(
            //     artisan['skills'].length,
            //     (index) => Container(
            //       padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            //       decoration: BoxDecoration(color: Colors.brown.shade50, borderRadius: BorderRadius.circular(20)),
            //       child: Text(
            //         artisan['skills'][index],
            //         style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.brown),
            //       ),
            //     ),
            //   ),
            // ),

            10.kH,

            // SizedBox(
            //   height: 30,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: artisan['skills'].length,
            //     itemBuilder: (context, index) {
            //       var skill = artisan['skills'][index];
            //       return Padding(
            //         padding: const EdgeInsets.only(right: 8.0),
            //         child: skillCard(skill),
            //       );
            //     },
            //   ),
            // ),


          ],
        ),
      ),
    ),
  );
}

