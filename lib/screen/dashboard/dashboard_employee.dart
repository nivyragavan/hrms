import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/dashboard_controller.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localization/localization.dart';

class DashBoardEmployee extends StatelessWidget {
  const DashBoardEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      await DashboardController .to
          .getDashboardAdmin();

    });
    return Obx( ()=>
       Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.14,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.25,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                // color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                      color: AppColors.grey.withOpacity(0.4), width: 3),
                  top: BorderSide(
                      color: AppColors.grey.withOpacity(0.4), width: 1),
                  left: BorderSide(
                      color: AppColors.grey.withOpacity(0.4), width: 1),
                  right: BorderSide(
                      color: AppColors.grey.withOpacity(0.4), width: 1),
                ),
              ),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.16,
                    width: 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Total Employees",
                        color: AppColors.grey,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      CustomText(
                        text: "324",
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              width: 16,
            );
          },
          itemCount: 4,
        ),
      ),
    );
  }
}
