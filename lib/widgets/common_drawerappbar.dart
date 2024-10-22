import 'package:dreamhrms/screen/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:page_transition/page_transition.dart';

import '../constants/colors.dart';
import '../controller/login_controller.dart';
import '../screen/drawer.dart';
import '../screen/splash.dart';

class AppBarDrawer extends StatefulWidget {
  const AppBarDrawer({Key? key}) : super(key: key);

  @override
  State<AppBarDrawer> createState() => _AppBarDrawerState();
}

class _AppBarDrawerState extends State<AppBarDrawer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              Get.to(NotificationScreen());
            },
            child: SvgPicture.asset('assets/icons/notification1.svg')),
        SizedBox(width: 8),
        InkWell(
          // child: Icon(Icons.logout)),
          child: Container(
            width: 38.0,
            height: 38.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    GetStorage().read("role") == 'employee'
                        ? GetStorage().read("UserImage")
                        : GetStorage().read("CompanyLogo"),
                  )),
              border: Border.all(color: AppColors.white, width: 3),
            ),
          ),
        ),
      ],
    );
  }
}
