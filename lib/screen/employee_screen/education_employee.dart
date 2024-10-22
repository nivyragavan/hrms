import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../employee/employee_details/profile.dart';

class EducationEmployee extends StatelessWidget {
  const EducationEmployee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero)
    //     .then((value) async => await ProfileController.to.getProfileList());
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                educationInformation(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

