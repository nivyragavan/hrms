import 'package:dreamhrms/screen/employee/documents/document_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:localization/localization.dart';

import '../../../constants/colors.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common.dart';
import 'doument_activity.dart';

class DocumentDetails extends StatelessWidget {
  final String url;
  const DocumentDetails({Key? key,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: "document_details",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TabBar(
                    isScrollable: true,
                    indicatorColor: AppColors.secondaryColor,
                    labelColor: AppColors.secondaryColor,
                    unselectedLabelColor: AppColors.grey,
                    tabs: [
                      Tab(text: "document_information"),
                      Tab(text: "activity"),
                    ],
                  ),
                ),
                // Divider()
              ],
            ),
          ),
          body: TabBarView(
            children: [
              DocumentsInformation(),
              DocumentsActivity(),
            ],
          ),
        ),
      ),
    );
  }
}
