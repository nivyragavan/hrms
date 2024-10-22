import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

import '../../../../constants/colors.dart';
import '../../../../controller/employee_details_controller/time_off_controller.dart';
import '../../../../services/provision_check.dart';
import '../../../../widgets/Custom_rich_text.dart';
import '../../../../widgets/Custom_text.dart';
import '../../../../widgets/no_record.dart';
import '../profile.dart';

class PermissionTabScreen extends StatelessWidget {
  const PermissionTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await TimeOffController.to.getPermissionHistory();
    });
    return Scaffold(
      body:
         Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: permissionDetails(),
        ),
      );
  }

  permissionDetails() {
    return Obx(() => commonLoader(
        length: 6,
        singleRow: true,
        loader: TimeOffController.to.showList,
        child: TimeOffController
                    .to.permissionHistory?.data?.historyList?.data?.length ==
                null
            ? NoRecord()
            : ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: TimeOffController.to.permissionHistory?.data
                        ?.historyList?.data?.length ??
                    0,
                itemBuilder: (BuildContext context, int index) {
                  var permissionList = TimeOffController
                      .to.permissionHistory?.data?.historyList?.data
                      ?.elementAt(index);
                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(15),
                    width: Get.width,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.lightGrey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: Get.width * 0.50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomRichText(
                                textAlign: TextAlign.left,
                                // textSpanTextAlign: TextAlign.left,
                                text:
                                    "${DateFormat('dd-MM-yyyy').format(DateTime.parse(permissionList!.permissionDate!))}",
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                textSpan:
                                    "${"applied_from".i18n} ${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss").parse(permissionList.fromTime!))} ${'to'} ${DateFormat('hh:mm a').format(DateFormat("hh:mm:ss").parse(permissionList.toTime!))}",
                                textSpanColor: AppColors.grey,
                                textSpanFontSize: 14,
                                textSpanFontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomRichText(
                                textAlign: TextAlign.left,
                                textSpanTextAlign: TextAlign.left,
                                text: permissionList.reasonForPermission!,
                                color: AppColors.grey.withOpacity(0.5),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: permissionList.status == "Pending"
                                  ? Color(0xFFFFC107).withOpacity(0.2)
                                  : permissionList.status == "Rejected"
                                      ? AppColors.lightRed
                                      : permissionList.status == "Approved"
                                          ? AppColors.lightGreen
                                          : AppColors.black,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(6))),
                          child: CustomText(
                            text: permissionList.status!,
                            color: permissionList.status == "${"pending"}"
                                ? Color(0xFFFFC107)
                                : permissionList.status == "${"rejected"}"
                                    ? AppColors.red
                                    : permissionList.status == "${"approved"}"
                                        ? AppColors.darkClrGreen
                                        : AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )));
  }
}
