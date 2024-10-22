import 'package:dreamhrms/model/settings/company/company_working_days_model.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../constants/colors.dart';
import '../controller/settings/company/company_settings.dart';

import 'Custom_rich_text.dart';
import 'common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import 'common_timePicker.dart';

class CompanySettingsExpansionTileWidget extends StatefulWidget {
  final CustomText title;
  final bool switchButton;
  final WorkingDay? WorkingDays;

  const CompanySettingsExpansionTileWidget(
      {Key? key,
      required this.title,
      required this.switchButton,
      required this.WorkingDays})
      : super(key: key);

  @override
  State<CompanySettingsExpansionTileWidget> createState() =>
      _CompanySettingsExpansionTileWidgetState();
}

class _CompanySettingsExpansionTileWidgetState
    extends State<CompanySettingsExpansionTileWidget> {
  bool isExpanded = false;
  void toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (ModalRoute.of(context)?.isCurrent == true) {
          toggleExpand();
        }
        ;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey.withOpacity(0.5)),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Theme(
              data:
                  Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                maintainState: true,
                title: InkWell(
                  // onTap: widget.ContainerOnClick,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          commonToggle(widget.switchButton),
                          SizedBox(width: 8),
                          widget.title,
                          SizedBox(height: 5),
                        ],
                      ),
                    ],
                  ),
                ),
                iconColor: AppColors.grey,
                // trailing:
                //     SvgPicture.asset("assets/icons/expansion_arrowup.svg"),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: 1, //widget.expansionList?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  // color: AppColors.blue.withOpacity(0.1),
                                  border: Border.all(
                                      color: AppColors.blue.withOpacity(0.1)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: _buildList());
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListTile(
      title: Obx(()=>
         Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRichText(
                textAlign: TextAlign.left,
                text: 'select_hours',
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textSpan: '',
                textSpanColor: AppColors.red),
            SizedBox(height: 5),
            MainSearchableDropDown(
                title: 'hours',
                hint: "Select Hours",
                isRequired: true,
                error: "hours_validation",
                items: [
                  {"hours": "Custom Hours"},
                  {"hours": "1 Hours"},
                  {"hours": "2 Hours"},
                  {"hours": "3 Hours"},
                  {"hours": "4 Hours"},
                ],
                controller: TextEditingController(
                    text: '${widget.WorkingDays?.customHours ?? ""}'),
                onChanged: (data) async {
                  widget.WorkingDays?.customHours = "09:00:00";
                }),
            SizedBox(height: 10),
            CustomRichText(
                textAlign: TextAlign.left,
                text: 'start_time',
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textSpan: '',
                textSpanColor: AppColors.red),
            SizedBox(height: 5),
            CommonTimePicker(
              controller: TextEditingController(
                  text: '${widget.WorkingDays?.startTime ?? "00:00:00"}'),
              focusedBorder: BorderSide(color: Colors.grey, width: 1.7),
              disabledBorder: BorderSide(color: Colors.black, width: 1),
              // hintText: "HH:MM",
              timeFormat: 'HH:mm:ss',
              readOnly: false,
              validator: (String? data) {
                if (data == "" || data == null) {
                  return "required_start_time";
                } else {
                  return null;
                }
              },
              onSaved: (data) async {
                widget.WorkingDays?.startTime = data!;
                print("startTime ${widget.WorkingDays?.startTime}");
                await findDiff(
                    start: widget.WorkingDays?.startTime.toString(),
                    end: widget.WorkingDays?.endTime.toString());
              },
            ),
            CustomRichText(
                textAlign: TextAlign.left,
                text: 'end_time',
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textSpan: '',
                textSpanColor: AppColors.red),
            SizedBox(height: 5),
            CommonTimePicker(
              controller: TextEditingController(
                  text: '${widget.WorkingDays?.endTime ?? "00:00:00"}'),
              focusedBorder: BorderSide(color: Colors.grey, width: 1.7),
              disabledBorder: BorderSide(color: Colors.black, width: 1),
              // hintText: "HH:MM",
              timeFormat: 'HH:mm:ss',
              readOnly: false,
              validator: (String? data) {
                if (data == "" || data == null) {
                  return "required_end_time";
                } else {
                  return null;
                }
              },
              onSaved: (data) async {
                print("end date format $data");
                print("test data on saved");
                widget.WorkingDays?.endTime = data!;
                print("endTime ${widget.WorkingDays?.endTime}");
                await findDiff(
                    start: widget.WorkingDays?.startTime.toString(),
                    end: widget.WorkingDays?.endTime.toString());
              },
            ),
            SizedBox(height: 5),
            CustomRichText(
                textAlign: TextAlign.left,
                text: 'total_hours',
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                textSpan: '',
                textSpanColor: AppColors.red),
            SizedBox(height: 5),
            CompanySettingsController.to.totalHrsLoader
                ? Skeleton(width: Get.width, height: 30)
                : CustomText(
                    text: '${widget.WorkingDays?.workingHours ?? "-"}',
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
          ],
        ),
      ),
      // Additional properties for each list item
    );
  }

  commonToggle(bool switchButton) {
    return FlutterSwitch(
      height: 25,
      width: 50,
      valueFontSize: 11,
      activeColor: AppColors.blue,
      activeTextColor: AppColors.grey,
      inactiveColor: AppColors.lightGrey,
      inactiveTextColor: AppColors.grey,
      value: switchButton,
      onToggle: (value) async {
        CompanySettingsController.to.companyLoader = true;
        widget.WorkingDays?.daysEnable = value;
        CompanySettingsController.to.companyLoader = false;
      },
    );
  }

  findDiff({String? start, String? end}) {
    CompanySettingsController.to.totalHrsLoader=true;
    if (start == null || end == null) {
      print("Start or end time is null.");
      return;
    }
    print("find diff of two choosen time $start end time $end");
    try {
      DateTime startTime = DateTime.parse("2023-10-25 " + start);
      DateTime endTime = DateTime.parse("2023-10-25 " + end);

      Duration difference = endTime.difference(startTime);
      widget.WorkingDays?.workingHours =
          "${difference.inHours.toString().padLeft(2, '0')}:${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}:00";
      print(
          "differences ${widget.WorkingDays?.workingHours} ${difference.inHours.toString().padLeft(2, '0')} minuts ${difference.inMinutes.remainder(60).toString().padLeft(2, '0')}");
      CompanySettingsController.to.totalHrsLoader=false;
    } catch (e) {
      print("Error: $e");
      CompanySettingsController.to.totalHrsLoader=false;
    }
  }
}
