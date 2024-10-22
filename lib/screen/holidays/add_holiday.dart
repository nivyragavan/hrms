import 'package:dotted_border/dotted_border.dart';
import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/holiday_controller.dart';
import 'package:dreamhrms/widgets/Custom_rich_text.dart';
import 'package:dreamhrms/widgets/common.dart';
import 'package:dreamhrms/widgets/common_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_datePicker.dart';

class AddHoliday extends StatelessWidget {
  final bool isEdit;
  AddHoliday({super.key, this.isEdit = false});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                navBackButton(),
                SizedBox(width: 8),
                CustomText(
                  text: isEdit ? "edit_holiday" : "add_holiday",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: "holiday_name",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 8),
                  CommonTextFormField(
                    controller: HolidayController.to.holidayName,
                    isBlackColors: true,
                    keyboardType: TextInputType.text,
                    validator: (String? data) {
                      if (data!.isEmpty) {
                        return "required_holiday_name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: "holiday_date",
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: ' *',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 8),
                  DatePicker(
                    controller: HolidayController.to.holidayDate,
                    hintText: 'select_date',
                    dateFormat: 'yyyy-MM-dd',
                    validator: (String? data) {
                      if (data!.isEmpty) {
                        return "required_date_holiday";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity / 1.2,
                    child: CommonButton(
                      text: "Submit Now",
                      textColor: AppColors.white,
                      buttonLoader: CommonController.to.buttonLoader,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      onPressed: () async {
                        if (formKey.currentState?.validate() == true) {
                          CommonController.to.buttonLoader = true;
                          isEdit
                              ? await HolidayController.to.editHoliday()
                              : await HolidayController.to.addHoliday();
                          CommonController.to.buttonLoader = false;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  BackToScreen(
                    text: "cancel",
                    arrowIcon: false,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
