import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../controller/common_controller.dart';
import '../../../controller/settings/company/company_settings.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/company_settings_expansion.dart';
import '../../../widgets/no_record.dart';
import '../company_settings.dart';

class CompanyWorkingDays extends StatelessWidget {
  const CompanyWorkingDays({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero).then((value) async {
      // await CompanySettingsController.to.seWorkingDays();
    });
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Obx(
            () => commonLoader(
              length: 7,
              singleRow: true,
              loader: CompanySettingsController.to.companyLoader,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CompanySettingsController.to.companyWorkingDaysModel
                              ?.workingDays.length ==
                          0
                      ? NoRecord()
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: CompanySettingsController
                                  .to
                                  .companyWorkingDaysModel
                                  ?.workingDays
                                  .length ??
                              0,
                          itemBuilder: (context, index) {
                            var WorkingDays = CompanySettingsController
                                .to
                                .companyWorkingDaysModel
                                ?.workingDays[index];
                            return CompanySettingsExpansionTileWidget(
                                title: CustomText(
                                  text: '${WorkingDays?.days}',
                                  color: AppColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                switchButton: WorkingDays!.daysEnable??false,
                                WorkingDays:
                                    WorkingDays //orkingDays?.customHours==""?"":
                                );
                          }),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          text: "save",
                          textColor: AppColors.white,
                          fontSize: 16,
                          buttonLoader: CommonController.to.buttonLoader,
                          fontWeight: FontWeight.w500,
                          // textAlign: TextAlign.center,
                          onPressed: () async {
                            CommonController.to.buttonLoader=true;
                            await CompanySettingsController.to.postCompanySettings();
                            CommonController.to.buttonLoader=false;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  BackToScreen(
                    text: "cancel",
                    arrowIcon: false,
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(height: 20),
                  BackToScreen(
                    text: "back",
                    arrowIcon: false,
                    onPressed: () {
                      Get.back();
                      Get.to(() => CompanySettings(selectedIndex: 1));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
