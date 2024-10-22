import 'package:dreamhrms/controller/branch_controller.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/screen/branch/add_branch_tabs/geofencing_screen.dart';
import 'package:dreamhrms/screen/branch/add_branch_tabs/office_details_screen.dart';
import 'package:dreamhrms/screen/branch/branch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localization/localization.dart';
import '../../constants/colors.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_text.dart';

class AddBranchScreen extends StatefulWidget {
  final int? index;
  const AddBranchScreen({Key? key, this.index = 0}) : super(key: key);

  @override
  State<AddBranchScreen> createState() => _AddBranchScreenState();
}

class _AddBranchScreenState extends State<AddBranchScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    setState(() {
      tabController!.index = widget.index ?? 0;
    });
    CommonController.to.clearValues();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: widget.index ?? 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => BranchScreen());
                },
                child: Icon(Icons.arrow_back_ios_new_outlined,
                    color: ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black),
              ),
              SizedBox(width: 8),
              CustomText(
                text: BranchController.to.isEdit == "Edit"? "edit_branch": "add_branch",
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TabBar(
                  indicatorColor: AppColors.blue,
                  isScrollable: true,
                  controller: tabController,
                  onTap: (value) {
                    setState(() {
                      tabController!.index = widget.index ?? 0;
                    });
                  },
                  unselectedLabelColor: AppColors.grey,
                  labelColor: AppColors.blue,
                  tabs: [
                    Tab(
                      text: "office_details",
                    ),
                    Tab(
                      text: "geofencing",
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [OfficeDetailsScreen(), GeofencingScreen()]),
      ),
    );
  }
}
