import 'package:dreamhrms/screen/permission/add_permission.dart';
import 'package:dreamhrms/screen/permission/permission_calendar.dart';
import 'package:dreamhrms/screen/permission/permission_history_list.dart';
import 'package:dreamhrms/screen/permission/permission_request_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';
import '../../constants/colors.dart';
import '../../controller/leave_add_permission_controller.dart';
import '../../controller/permission_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';


class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero)
        .then((value) async {
      await PermissionController.to.getPermissionHistory();
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                      text: "permission",
                      color: AppColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      LeaveAddPermissionController.to.onClose();
                      Get.to(() => AddPermission());
                    },
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Icon(Icons.add, color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            height: Get.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: PermissionCalendar(),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: Get.width * 0.50,
                //         child: Row(
                //           children: [
                //             Container(
                //               height: 43,
                //               width: 46,
                //               decoration: BoxDecoration(
                //                 color: Color(0xFFEAEEF6),
                //                 borderRadius: BorderRadius.circular(8.0),
                //               ),
                //               child: Center(
                //                 child: SvgPicture.asset(
                //                   'assets/icons/leave_annual.svg',
                //                 ),
                //               ),
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 CustomText(
                //                     text: 'Annual',
                //                     color: AppColors.black,
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w600),
                //                 SizedBox(
                //                   height: 5,
                //                 ),
                //                 CustomText(
                //                     text: '13 Emp Applied',
                //                     color: AppColors.black,
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.w400),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //       Row(
                //         children: [
                //           Container(
                //             height: 43,
                //             width: 46,
                //             decoration: BoxDecoration(
                //               color: Color(0xFFEBFFDD),
                //               borderRadius: BorderRadius.circular(8.0),
                //             ),
                //             child: Center(
                //               child: SvgPicture.asset(
                //                 'assets/icons/leave_vacation.svg',
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             width: 10,
                //           ),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               CustomText(
                //                   text: 'Vacation',
                //                   color: AppColors.black,
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w600),
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               CustomText(
                //                   text: '8 Emp Applied',
                //                   color: AppColors.black,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400),
                //             ],
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: 30,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: Row(
                //     children: [
                //       SizedBox(
                //         width: Get.width * 0.50,
                //         child: Row(
                //           children: [
                //             Container(
                //               height: 43,
                //               width: 46,
                //               decoration: BoxDecoration(
                //                 color: Color(0xFFFFF4EB),
                //                 borderRadius: BorderRadius.circular(8.0),
                //               ),
                //               child: Center(
                //                 child: SvgPicture.asset(
                //                   'assets/icons/leave_medical.svg',
                //                 ),
                //               ),
                //             ),
                //             SizedBox(
                //               width: 10,
                //             ),
                //             Column(
                //               crossAxisAlignment: CrossAxisAlignment.start,
                //               children: [
                //                 CustomText(
                //                     text: 'Medical',
                //                     color: AppColors.black,
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w600),
                //                 SizedBox(
                //                   height: 5,
                //                 ),
                //                 CustomText(
                //                     text: '10 Emp Applied',
                //                     color: AppColors.black,
                //                     fontSize: 12,
                //                     fontWeight: FontWeight.w400),
                //               ],
                //             )
                //           ],
                //         ),
                //       ),
                //       Row(
                //         children: [
                //           Container(
                //             height: 43,
                //             width: 46,
                //             decoration: BoxDecoration(
                //               color: Color(0xFFF2F0FE),
                //               borderRadius: BorderRadius.circular(8.0),
                //             ),
                //             child: Center(
                //               child: SvgPicture.asset(
                //                 'assets/icons/leave_loss_of_pay.svg',
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             width: 10,
                //           ),
                //           Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               CustomText(
                //                   text: 'Loss of Pay',
                //                   color: AppColors.black,
                //                   fontSize: 14,
                //                   fontWeight: FontWeight.w600),
                //               SizedBox(
                //                 height: 5,
                //               ),
                //               CustomText(
                //                   text: '20 Emp Applied',
                //                   color: AppColors.black,
                //                   fontSize: 12,
                //                   fontWeight: FontWeight.w400),
                //             ],
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                TabBar(
                    labelColor: AppColors.blue,
                    unselectedLabelColor: AppColors.grey,
                    indicatorColor: AppColors.blue,
                    tabs: [
                      Tab(text: "request_list"),
                      Tab(text: "history_list")
                    ]),
                Expanded(
                  child: TabBarView(
                    children: [
                      PermissionRequestList(),
                      PermissionHistoryList()
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
