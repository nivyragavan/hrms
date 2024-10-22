// import 'package:dreamhrms/colors.dart';
// import 'package:dreamhrms/controller/leave_controller.dart';
// import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
// import 'package:dreamhrms/widgets/Custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:localization/localization.dart';
//
// import '../../widgets/no_record.dart';
//
// class LeaveRejected extends StatelessWidget {
//   const LeaveRejected({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration.zero).then((value) async {
//       await LeaveController.to.getLeaveHistory();
//     });
//     return Scaffold(
//       body: Column(
//         children: [
//           Obx(
//             () => Padding(
//               padding: EdgeInsets.all(12),
//               child: commonLoader(
//                 length: 6,
//                 singleRow: true,
//                 loader: LeaveController.to.showList,
//                 child: SingleChildScrollView(
//                   child: LeaveController.to.rejectedList.length == 0
//                       ? NoRecord()
//                       : ListView.builder(
//                           itemCount:
//                               LeaveController.to.rejectedList.length ?? 0,
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           physics: ScrollPhysics(),
//                           itemBuilder: (BuildContext context, int index) {
//                             var historyData = LeaveController.to.rejectedList
//                                 ?.elementAt(index);
//                             return Container(
//                               margin: EdgeInsets.only(bottom: 15),
//                               height:
//                                   MediaQuery.of(context).size.height * 0.13,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(
//                                   12.0,
//                                 ),
//                                 border: Border.all(
//                                   color: AppColors.grey.withOpacity(0.3),
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 8.0, vertical: 8.0),
//                                 child: Row(
//                                   // direction: Axis.horizontal,
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           width: 226,
//                                           child: ListTile(
//                                             dense: true,
//                                             leading: CircleAvatar(
//                                               radius: 25,
//                                               backgroundColor:
//                                                   Colors.transparent,
//                                               backgroundImage: NetworkImage(
//                                                   historyData?.users
//                                                           ?.profileImage ??
//                                                       ""),
//                                             ),
//                                             title: CustomText(
//                                                 text:
//                                                     "${historyData?.users?.firstName}"
//                                                         ,
//                                                 color: AppColors.black,
//                                                 fontSize: 14,
//                                                 fontWeight: FontWeight.w600),
//                                             subtitle: CustomText(
//                                                 text:
//                                                     "${historyData?.users?.department?.departmentName}"
//                                                         ,
//                                                 color: AppColors.grey,
//                                                 fontSize: 11,
//                                                 fontWeight: FontWeight.w500),
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             CustomText(
//                                                 text:
//                                                     "${historyData?.leaveType}"
//                                                         ,
//                                                 color: AppColors.blue,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w500),
//                                             SizedBox(
//                                               width: 6,
//                                             ),
//                                             CircleAvatar(
//                                               radius: 4,
//                                             ),
//                                             SizedBox(
//                                               width: 6,
//                                             ),
//                                             CustomText(
//                                                 text:
//                                                     "${DateFormat("dd-MM-yyyy").format(historyData!.leaveFrom!)} - ${DateFormat("dd-MM-yyyy").format(historyData.leaveTo!)}",
//                                                 color: AppColors.black,
//                                                 fontSize: 12,
//                                                 fontWeight: FontWeight.w400),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         _buildStatusContainer(
//                                             historyData?.status ?? ""),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   _buildStatusContainer(String status) {
//     return Container(
//       height: 24,
//       width: 80,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(4.0),
//         color: status == "Pending"
//             ? Color(0xFFFFC107).withOpacity(0.2)
//             : status == "Rejected"
//                 ? AppColors.lightRed
//                 : status == "Approved"
//                     ? AppColors.lightGreen
//                     : AppColors.black,
//       ),
//       child: Center(
//         child: CustomText(
//             text: status,
//             color: status == "Pending"
//                 ? Color(0xFFFFC107)
//                 : status == "Rejected"
//                     ? AppColors.red
//                     : status == "Approved"
//                         ? AppColors.darkClrGreen
//                         : AppColors.black,
//             fontSize: 11,
//             fontWeight: FontWeight.w500),
//       ),
//     );
//   }
// }
