// import 'package:dreamhrms/controller/department/add_department_controller.dart';
// import 'package:dreamhrms/controller/department/deparrtment_controller.dart';
// import 'package:dreamhrms/controller/settings/leave_settings_list_model.dart';
// import 'package:dreamhrms/widgets/Custom_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_switch/flutter_switch.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:localization/localization.dart';
// import 'package:skeleton_animation/skeleton_animation.dart';
//
// import '../constants/colors.dart';
// import '../controller/settings/leave/annual_leave_controller.dart';
// import '../screen/settings/leave_settings/leave_annual.dart';
// import 'Custom_rich_text.dart';
// import 'common_button.dart';
// import 'common_textformfield.dart';
//
// class LeaveSettingsExpansionTile extends StatefulWidget {
//   final Data? expansionList;
//   // final CustomText title;
//   // final CustomText subTitle;
//   // final Image image;
//   // final List<Positions>? expansionList;
//   // final VoidCallback editOnPressed;
//   // final VoidCallback ContainerOnClick;
//   // final VoidCallback headerEditOnPressed;
//   // final int mainIndex;
//   // final SvgPicture editIcon;
//   // final String value;
//   // final bool? editicon;
//   const LeaveSettingsExpansionTile({
//     Key? key,
//     this.expansionList,
//     // required this.title,
//     // required this.subTitle,
//     // required this.expansionList,
//     // required this.editOnPressed,
//     // required this.ContainerOnClick,
//     // required this.image,
//     // required this.mainIndex,
//     // required this.editIcon,
//     // required this.value,
//     // this.editicon = true,
//     // required this.headerEditOnPressed
//   }) : super(key: key);
//
//   @override
//   State<LeaveSettingsExpansionTile> createState() =>
//       _LeaveSettingsExpansionTileState();
// }
//
// class _LeaveSettingsExpansionTileState
//     extends State<LeaveSettingsExpansionTile> {
//   bool isExpanded = false;
//   void toggleExpand() {
//     setState(() {
//       isExpanded = !isExpanded;
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     AnnualLeaveController.to.dayController.text =
//     '${widget.expansionList?.carryForwardDays}';
//     AnnualLeaveController.to.maxDaysController.text =
//     '${widget.expansionList?.earnedLeaveDays}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (ModalRoute.of(context)?.isCurrent == true) {
//           toggleExpand();
//         }
//         ;
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Container(
//           decoration: BoxDecoration(
//               border: Border.all(color: AppColors.grey.withOpacity(0.5)),
//               borderRadius: BorderRadius.all(Radius.circular(8))),
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Theme(
//               data:
//                   Theme.of(context).copyWith(dividerColor: Colors.transparent),
//               child: ExpansionTile(
//                 maintainState: true,
//                 title: InkWell(
//                   // onTap: widget.ContainerOnClick,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CustomText(
//                         text: '${widget.expansionList?.name ?? "-"}',
//                         color: AppColors.black,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       FlutterSwitch(
//                           height: 25,
//                           width: 50,
//                           padding: 2,
//                           valueFontSize: 11,
//                           activeColor: AppColors.blue,
//                           activeTextColor: AppColors.grey,
//                           inactiveColor: AppColors.lightGrey,
//                           inactiveTextColor: AppColors.grey,
//                           value: true,
//                           onToggle: (val) {
//                             // ThemeController.to.isDarkTheme = val;
//                             // Get.changeThemeMode(
//                             //   ThemeController.to.isDarkTheme
//                             //       ? ThemeMode.dark
//                             //       : ThemeMode.light,
//                             // );
//                             // ThemeController.to.saveThemeStatus();
//                           }),
//                     ],
//                   ),
//                 ),
//                 iconColor: AppColors.grey,
//                 trailing: CircleAvatar(
//                   radius: 18,
//                   backgroundColor: AppColors.grey.withOpacity(0.1),
//                   child: Icon(
//                     Icons.keyboard_arrow_down_outlined,
//                     color: AppColors.grey.withOpacity(0.8),
//                     size: 30, // Custom icon for the collapsed state
//                     // Additional properties for the icon
//                   ),
//                 ),
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[_buildList(context)],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static final form = GlobalKey<FormState>();
//   Widget _buildList(BuildContext context) {
//     AnnualLeaveController.to.dayController.text =
//         '${widget.expansionList?.carryForwardDays??""}';
//     AnnualLeaveController.to.maxDaysController.text =
//         '${widget.expansionList?.carryForwardDays??""}';
//     return Obx(
//       () => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 3),
//         child: AnnualLeaveController.to.leaveSettingsLoader
//             ? Skeleton(width: Get.width)
//             : Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       CommonButton(
//                         text: "Edit",
//                         textColor: AppColors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                         textAlign: TextAlign.center,
//                         iconText: true,
//                         icons: Icons.flag_outlined,
//                         onPressed: () {
//                           AnnualLeaveController.to.edit = true;
//                         },
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: SizedBox(
//                           // width: 180,height: 30,
//                           child: CommonButton(
//                             text: "add_custom_policy",
//                             textColor: AppColors.white,
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                             textAlign: TextAlign.center,
//                             iconText: true,
//                             icons: Icons.add,
//                             onPressed: () {
//                               showAddCustomPolicyBottomSheet(form: form);
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   CustomRichText(
//                       textAlign: TextAlign.left,
//                       text: "Days",
//                       color: AppColors.black,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       textSpan: ' ',
//                       textSpanColor: AppColors.red),
//                   SizedBox(height: 10),
//                   CommonTextFormField(
//                     controller: AnnualLeaveController.to.dayController,
//                     isBlackColors: true,
//                     readOnly: AnnualLeaveController.to.edit,
//                     keyboardType: TextInputType.number,
//                     validator: (String? data) {
//                       // if (data == "" || data == null) {
//                       //   print("Empty data");
//                       //   return "first_name_validator";
//                       // } else {
//                       //   return null;
//                       // }
//                     },
//                   ),
//                   SizedBox(height: 5),
//                   CustomRichText(
//                       textAlign: TextAlign.left,
//                       text: "Max Days",
//                       color: AppColors.black,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w400,
//                       textSpan: ' ',
//                       textSpanColor: AppColors.red),
//                   SizedBox(height: 5),
//                   CommonTextFormField(
//                     controller: AnnualLeaveController.to.maxDaysController,
//                     isBlackColors: true,
//                     readOnly: AnnualLeaveController.to.edit,
//                     keyboardType: TextInputType.number,
//                     validator: (String? data) {
//                       // if (data == "" || data == null) {
//                       //   print("Empty data");
//                       //   return "first_name_validator";
//                       // } else {
//                       //   return null;
//                       // }
//                     },
//                   ),
//                 ],
//               ),
//       ),
//     );
//   }
// }
