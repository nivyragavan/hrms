import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../constants/colors.dart';
import '../controller/common_controller.dart';
import '../controller/edit_employee_profile_controller.dart';
import '../controller/settings/notification/notification_settings_controller.dart';
import 'Custom_text.dart';
import 'image_picker.dart';

navBackButton() {
  return InkWell(
      onTap: () {
        Get.back();
      },
      child: IconButton(onPressed: () {
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios_new_outlined,),
      ));
}

showImagePicker(BuildContext context,
    {required bool showGallery,
    required bool showCamera,
    required TextEditingController controller}) {
  showBottomSheet(
    backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return CustomImagePicker(
            controller: controller,
            showGallery: true,
            showCamera: false,
          );
        });
      });
}

void commonTapHandler() {
  FocusManager.instance.primaryFocus?.unfocus();
}

class FallbackImageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/user.jpeg",
      fit: BoxFit.contain,
    );
  }
}


pickFiles(
    {String? key,
    required TextEditingController controller,
    required TextEditingController binary,
    bool? loader}) async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['doc', 'pdf']);
  if (result != null) {
    // File file = File('${result.files.single.path}');
    try {
      loader = true;
      CommonController.to.fileLoader = true;
      controller.text = result.files.single.name;
      String filePath = result.files.single.path ?? "";
      final file = File(filePath);
      final fileSizeInBytes = file.lengthSync();
      final fileSizeInMB = fileSizeInBytes ~/ (1024 * 1024);
      CommonController.to.officeImageSize = fileSizeInMB;
      print(controller.text);
      print("path ${result.files.single.path}");
      binary.text = '${result.files.single.path.toString() ?? ""}';
      loader = false;
      CommonController.to.fileLoader = false;
    } catch (e) {
      print("Exception $e");
    }
  } else {
    print('File choosen cancel..');
  }
}

commonNetworkImageDisplay(String image) {
  return image != null && image != ""
      ? image
      : "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78A"
          "xPTh9EApaPU2kXh2evb499JgW99b0g=";
}

BoxDecoration skeletonBoxDecoration = BoxDecoration(
  // color: AppColors.white,
  boxShadow: const [
    // BoxShadow(
    //   color: Colors.grey,
    //   offset: Offset(0.0, 1.0),
    //   blurRadius: 6.0,
    // ),
  ],
);
commonDataDisplay(
    {required String title1,
    required String text1,
    double? titleFontSize1,
    double? textFontSize1,
    required String title2,
    required String text2,
    double? titleFontSize2,
    double? textFontSize2,  double? width}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width==null || width==""?Get.width * 0.40:width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: title1,
                  color: AppColors.grey,
                  fontSize: titleFontSize1 == null ? 11 : titleFontSize1,
                  fontWeight: FontWeight.w400),
              SizedBox(height: 5),
              CustomText(
                  text: text1,
                  color: AppColors.black,
                  fontSize: textFontSize1 == null ? 13 : textFontSize1,
                  fontWeight: FontWeight.w500),
            ],
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: Get.width * 0.40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  text: title2,
                  color: AppColors.grey,
                  fontSize: titleFontSize2 == null ? 11 : titleFontSize2,
                  fontWeight: FontWeight.w400),
              SizedBox(height: 5),
              CustomText(
                  text: text2,
                  color: AppColors.black,
                  fontSize: textFontSize2 == null ? 13 : textFontSize2,
                  fontWeight: FontWeight.w500),
            ],
          ),
        ),
      ],
    ),
  );
}

commonSingleDataDisplay(
    {required String title1,
    required String text1,
    required double titleFontSize,
    required double textFontSize,
    Color? textFontColor,
    FontWeight? titleFontWeight,
    FontWeight? textFontWeight,
    Color? titleFontColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: title1,
                color: titleFontColor == null ? AppColors.grey : titleFontColor,
                fontSize: titleFontSize,
                fontWeight: titleFontWeight == null
                    ? FontWeight.w400
                    : titleFontWeight),
            SizedBox(height: 5),
            CustomText(
                text: text1,
                color: textFontColor == null ? AppColors.black : textFontColor,
                fontSize: textFontSize,
                fontWeight:
                    textFontWeight == null ? FontWeight.w500 : textFontWeight),
          ],
        ),
      ],
    ),
  );
}

commonMenuDisplay(
    {required String image,
    required String text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required Color imageColor,
    required VoidCallback onPressed}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(image, color: imageColor),
          SizedBox(width: 5),
          CustomText(
            text: text,
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ],
      ),
    ),
  );
}

commonFlutterSwitch({double? width = 50.0, double? height = 25.0, String? value, required Function(dynamic) onToggle}){
  final actualWidth = width ?? 50.0;
  final actualHeight = height ?? 25.0;
    return FlutterSwitch(
    height: 25,
    width:50,
    valueFontSize: 11,
    activeColor: AppColors.blue,
    activeTextColor: AppColors.grey,
    // inactiveColor: AppColors.lightGrey,
    inactiveTextColor: AppColors.grey,
    value: value.toString()=="1"?true:false,
    onToggle:(val){
      print("toggle val $val");
      onToggle(val);
    }
  );
}
String? getToggleController(
    {required String key, required int index}) {
  print("update key $key  index$index");
  switch (key) {
    case "Push":
      return NotificationSettingsController
          .to.notificationSettingsModel?.data?[index].push;
    case "Email":
      return NotificationSettingsController
          .to.notificationSettingsModel?.data?[index].email;
    case "Text":
      return NotificationSettingsController
          .to.notificationSettingsModel?.data?[index].sms ;
  }
}

String? updateToggleController(
    {required String key, required String value, required int index}) {
  print("update key $key value$value index$index");
  switch (key) {
    case "Push":
      NotificationSettingsController
          .to.notificationSettingsModel?.data?[index].push=value;
      break;
    case "Email":
      NotificationSettingsController
          .to.notificationSettingsModel?.data?[index].email=value;
      break;
    case "Text":
      NotificationSettingsController
          .to.notificationSettingsModel?.data?[index].sms=value;
      break;
  }
}