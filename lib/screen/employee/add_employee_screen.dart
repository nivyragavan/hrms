import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../controller/employee/employee_controller.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/common.dart';
import 'add_employee_tabs/dependency_screen.dart';
import 'add_employee_tabs/documents_screen.dart';
import 'add_employee_tabs/educational_screen.dart';
import 'add_employee_tabs/employee_screen.dart';
import 'add_employee_tabs/personal_screen.dart';

class AddEmployeeScreen extends StatefulWidget {
  final int? selectedIndex;
  const AddEmployeeScreen({Key? key, this.selectedIndex = 0}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    setState(() {
      tabController!.index = widget.selectedIndex ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: widget.selectedIndex ?? 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              navBackButton(),
              SizedBox(width: 8),
              CustomText(
                text: EmployeeController.to.isEmployee == "Edit"
                    ? "Edit Employees"
                    : "Add Employees",
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
          bottom: TabBar(
            controller: tabController,
            onTap: (value) {
              tabController!.index = widget.selectedIndex ?? 0;
            },
            isScrollable: true,
            physics: NeverScrollableScrollPhysics(),
            // labelPadding:EdgeInsets.only(right: 10),
            unselectedLabelColor: AppColors.grey,
            labelColor: AppColors.blue,
            indicatorColor: AppColors.blue,
            tabs: [
              Tab(child: Text("Personal")),
              Tab(child: Text("Employee")),
              Tab(child: Text("Dependency")),
              Tab(child: Text("Educational")),
              Tab(child: Text("Documents"))
            ],
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: tabController,

          children: [
            PersonalScreen(),
            EmployeeScreen(),
            DependencyScreen(),
            EducationalScreen(),
            DocumentsScreen()
          ],
        ),
      ),
    );
  }

}
