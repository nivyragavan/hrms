import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/announcement_controller.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DashboardAnnouncement extends StatelessWidget {
  const DashboardAnnouncement({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await AnnouncementController.to.getAnnouncementList();
      //await OffBoardingChecklistController.to.getChecklist();
    });
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.12,
      width: MediaQuery.of(context).size.width * 0.99,
      child: Obx( ()=>
         commonLoader(
           length: 1,
           loader: AnnouncementController.to.showList,
           width: Get.width,
           singleRow: true,
           child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: AnnouncementController.to.announcementListModel?.data?.length,
              itemBuilder: (context, index) {
                var data = AnnouncementController.to.announcementListModel?.data?[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    decoration: BoxDecoration(
                      // color: AppColors.white,
                      border: Border.all(
                        color: AppColors.grey.withOpacity(0.3),
                        // width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      title: CustomText(
                        text: data?.subject ?? "",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: CustomText(
                        text: "5 Minutes Ago",
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.more_vert),
                        onPressed: () {},
                      ),
                    ),
                  ),
                );
              }),
         ),
      ),
    );
  }
}
