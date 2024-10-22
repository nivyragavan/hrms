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

class LeaveTabScreen extends StatelessWidget {
  const LeaveTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      await TimeOffController.to.getLeaveHistory();
    });
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: leaveDetails(),
    ));
  }

  leaveDetails() {
    return Obx(() => commonLoader(
        length: 6,
        singleRow: true,
        loader: TimeOffController.to.showList,
        child: TimeOffController
                    .to.leaveHistory?.data?.historyList?.data?.length ==
                null
            ? NoRecord()
            : ViewProvisionedWidget(
                provision: "leave",
                type: 'view',
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: TimeOffController
                          .to.leaveHistory?.data?.historyList?.data?.length ??
                      0,
                  itemBuilder: (BuildContext context, int index) {
                    var leaveList = TimeOffController
                        .to.leaveHistory?.data?.historyList?.data
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
                                  text: leaveList!.leaveType!,
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  textSpan: leaveList.leaveFrom == null ||
                                          leaveList.leaveFrom == ""
                                      ? "-"
                                      : "${"applied_from"} ${DateFormat('dd MMM').format(DateTime.parse(leaveList.leaveFrom!))} ${'to'} ${DateFormat('dd MMM').format(DateTime.parse(leaveList.leaveTo!))}",
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
                                  text:
                                      "${DateFormat('dd.MM.yyyy hh:mm a').format(leaveList.createdAt!)}",
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
                                color: leaveList.status == "${"pending"}"
                                    ? Color(0xFFFFC107).withOpacity(0.2)
                                    : leaveList.status == "${"rejected"}"
                                        ? AppColors.lightRed
                                        : leaveList.status ==
                                                "${"approved"}"
                                            ? AppColors.lightGreen
                                            : AppColors.black,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6))),
                            child: CustomText(
                              text: leaveList.status!,
                              color: leaveList.status == "${"pending"}"
                                  ? Color(0xFFFFC107)
                                  : leaveList.status == "${"rejected"}"
                                      ? AppColors.red
                                      : leaveList.status ==
                                              "${"approved"}"
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
                ),
              )));
  }
}
