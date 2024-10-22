import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants/colors.dart';
import 'Custom_text.dart';

class NoRecord extends StatefulWidget {
  const NoRecord({Key? key}) : super(key: key);

  @override
  State<NoRecord> createState() => _NoRecordState();
}

class _NoRecordState extends State<NoRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // child: Center(
      //   child: CustomText(
      //     textAlign:TextAlign.center,
      //     text: "No Record Found",
      //     color: AppColors.red,
      //     fontSize: 15,
      //     fontWeight: FontWeight.bold,
      //   )
      // )
      child: Center(child:Lottie.asset(
        'assets/gif/no_record_found.json',
        repeat: true,
        reverse: false,
        animate: true,
      ),),
    );
  }
}

class ServerError extends StatefulWidget {
  const ServerError({super.key});

  @override
  State<ServerError> createState() => _ServerErrorState();
}

class _ServerErrorState extends State<ServerError> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      // child: Center(
      //   child: CustomText(
      //     textAlign:TextAlign.center,
      //     text: "No Record Found",
      //     color: AppColors.red,
      //     fontSize: 15,
      //     fontWeight: FontWeight.bold,
      //   )
      // )
      child: Center(child:Lottie.asset(
        'assets/gif/server_error.json',
        repeat: true,
        reverse: false,
        animate: true,
      ),),
    );
  }
}


class NoViewPermission extends StatefulWidget {
  const NoViewPermission({Key? key}) : super(key: key);

  @override
  State<NoViewPermission> createState() => _NoViewPermissionState();
}

class _NoViewPermissionState extends State<NoViewPermission> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: CustomText(
          textAlign:TextAlign.center,
          text: "You don't have an view permission",
          color: AppColors.red,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
