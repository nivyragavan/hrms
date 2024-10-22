import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class DashboardTeam extends StatelessWidget {
  const DashboardTeam({super.key});

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width * 0.65;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      width: MediaQuery.of(context).size.width * 0.99,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          var ownerImg =
              "https://media.istockphoto.com/id/1318482009/photo/young-woman-ready-for-job-business-concept.jpg?s=612x612&w=0&k=20&c=Jc1NcoUMoM78AxPTh9EApaPU2kXh2evb499JgW99b0g=";
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              decoration: BoxDecoration(
                  // color: AppColors.white,
                  border: Border.all(
                    color: AppColors.grey.withOpacity(0.3),
                    // width: 1.0,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ListTile(
                      leading: ClipOval(
                          child: Image.network(
                        ownerImg,
                        fit: BoxFit.cover,
                        width: 50.0,
                        height: 50.0,
                      )),
                      title: CustomText(
                        text: "John Walker",
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      subtitle: CustomText(
                        text: "Team Leader",
                        color: AppColors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    _buildStatusContainer(
                        index.isOdd ? "Present" : "Absent", context, itemWidth),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _buildStatusContainer(String status, BuildContext context, double itemWidth) {
    double itemWidth = MediaQuery.of(context).size.width * 0.65;
    return Container(
      height: 40,
      width: itemWidth,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            width: 1.2,
            color: status == "Present"
                ? ThemeController.to.checkThemeCondition() == true
                    ? AppColors.green.withOpacity(0.4)
                    : AppColors.lightGreen
                : status == "Absent"
                    ? ThemeController.to.checkThemeCondition() == true
                        ? AppColors.red.withOpacity(0.4)
                        : AppColors.lightRed
                    : AppColors.black,
          ),
          color: status == "Present"
              ? ThemeController.to.checkThemeCondition() == true
                  ? AppColors.green.withOpacity(0.4)
                  : AppColors.lightGreen
              : status == "Absent"
                  ? ThemeController.to.checkThemeCondition() == true
                      ? AppColors.red.withOpacity(0.4)
                      : AppColors.lightRed
                  : AppColors.black),
      child: Center(
        child: CustomText(
            text: status,
            color: status == "Present"
                ? AppColors.green
                : status == "Absent"
                    ? AppColors.red
                    : AppColors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
