import 'package:dreamhrms/screen/employee/asset_details/asset_info.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../constants/colors.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import 'company_settings/company_account_owner.dart';
import 'company_settings/company_contact_details.dart';
import 'company_settings/company_profile.dart';
import 'company_settings/company_working_days.dart';
import 'notification_settings/Manager_Alerts.dart';
import 'notification_settings/shift_schedule_notification.dart';

class NotificationSettings extends StatefulWidget {
  final int? selectedIndex;
  const NotificationSettings({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    setState(() {
      tabController!.index = widget.selectedIndex ?? 0;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        // leading: Icon(Icons.arrow_back_ios_new_outlined,color: AppColors.black),
        title: Row(
          children: [
            navBackButton(),
            SizedBox(width: 8),
            CustomText(
              text: "notification_setting",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        initialIndex: widget.selectedIndex ?? 0,
        child: Scaffold(
          
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            centerTitle: false,
            elevation: 0,
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TabBar(
                    controller: tabController,
                    onTap: (value) {
                      setState(() {
                        tabController!.index = widget.selectedIndex ?? 0;
                      });
                    },
                    isScrollable: true,
                    physics: NeverScrollableScrollPhysics(),
                    indicatorColor: AppColors.secondaryColor,
                    labelColor: AppColors.secondaryColor,
                    unselectedLabelColor: AppColors.grey,
                    tabs: [
                      Tab(text: "shift_schedule"),
                      Tab(text: "manager_alerts"),
                    ],
                  ),
                ),
                // Divider()
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              ShiftScheduleNotification(),
              ManagerAlerts(),
            ],
          ),
        ),
      ),
    );
  }
}
