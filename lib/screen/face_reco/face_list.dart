import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/controller/face_controller.dart';
import 'package:dreamhrms/screen/face_reco/employee_face_card.dart';
import 'package:dreamhrms/widgets/Custom_text.dart';
import 'package:dreamhrms/widgets/back_to_screen.dart';
import 'package:dreamhrms/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localization/localization.dart';

import '../../widgets/common.dart';

class FaceList extends StatefulWidget {
  const FaceList({super.key});

  @override
  State<FaceList> createState() => _FaceListState();
}

class _FaceListState extends State<FaceList> {
  final _scrollController = ScrollController();
  int tabIndex = 0;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FaceController.to.getFaceList(page: 1);
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("scrolling ");
        if (FaceController.to.lastPage > page) {
          page = page + 1;
          FaceController.to.getFaceList(
              page: page,
              status: tabIndex == 0
                  ? null
                  : tabIndex == 1
                      ? 0
                      : tabIndex == 2
                          ? 1
                          : 2);
        }
      }
    });
  }

  showConfirm({required int status, required int id}) {
    return Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SvgPicture.asset('assets/icons/tick.svg'),
                      CircleAvatar(
                        backgroundColor: status == 2
                            ? AppColors.lightRed
                            : AppColors.lightGreen,
                        radius: 15,
                        child: Icon(
                          status == 2 ? Icons.close : Icons.check,
                          color: status == 2
                              ? AppColors.red
                              : AppColors.darkClrGreen,
                          size: 18,
                        ),
                      ),
                      SizedBox(height: 15),
                      CustomText(
                        text:
                            'Are you sure want to ${status == 1 ? "Approve" : "Reject"} this face?',
                        color: AppColors.black,
                        fontSize: 18,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: 20),
                      Obx(
                        () => Row(
                          children: [
                            Expanded(
                              child: CommonButton(
                                text: "confirm",
                                textColor: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                buttonLoader: CommonController.to.buttonLoader,
                                onPressed: () async {
                                  CommonController.to.buttonLoader = true;
                                  await FaceController.to
                                      .changeFaceStatus(id: id, status: status);
                                  CommonController.to.buttonLoader = false;
                                  page = 1;
                                  if (tabIndex == 0) {
                                    FaceController.to.getFaceList(page: 1);
                                  } else if (tabIndex == 1) {
                                    FaceController.to
                                        .getFaceList(page: 1, status: 0);
                                  } else if (tabIndex == 2) {
                                    FaceController.to
                                        .getFaceList(page: 1, status: 1);
                                  } else if (tabIndex == 3) {
                                    FaceController.to
                                        .getFaceList(page: 1, status: 2);
                                  }
                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      BackToScreen(
                        text: "cancel",
                        arrowIcon: false,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      navBackButton(),
                      SizedBox(width: 8),
                      CustomText(
                        text: "Face List",
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Container(
                height: Get.height,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  TabBar(
                      labelColor: AppColors.blue,
                      unselectedLabelColor: AppColors.grey,
                      indicatorColor: AppColors.blue,
                      onTap: (value) {
                        tabIndex = value;
                        page = 1;
                        if (value == 0) {
                          FaceController.to.getFaceList(page: 1);
                        } else if (value == 1) {
                          FaceController.to.getFaceList(page: 1, status: 0);
                        } else if (value == 2) {
                          FaceController.to.getFaceList(page: 1, status: 1);
                        } else if (value == 3) {
                          FaceController.to.getFaceList(page: 1, status: 2);
                        }
                      },
                      tabs: [
                        Tab(text: "All"),
                        Tab(text: "Pending"),
                        Tab(
                          text: "Approved",
                        ),
                        Tab(text: "Rejected")
                      ]),
                  Obx(() => Expanded(
                        child: Container(
                            child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (FaceController.to.faceList.length == 0 &&
                                FaceController.to.loading == false)
                              Expanded(
                                child: Center(
                                  child: CustomText(
                                    text: "No Data Found",
                                    color: AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            if (FaceController.to.faceList.length > 0)
                              Expanded(
                                child: ListView.builder(
                                    physics: const ScrollPhysics(),
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        FaceController.to.faceList.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 0.5),
                                        child: EmployeeFaceCard(
                                          face:
                                              FaceController.to.faceList[index],
                                          onActionPressed: (
                                              {required int id,
                                              required int status}) {
                                            showConfirm(status: status, id: id);
                                          },
                                        ),
                                      );
                                    }),
                              ),
                            if (FaceController.to.loading == true)
                              Container(
                                height: 150,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.darkClrGreen,
                                  ),
                                ),
                              ),
                          ],
                        )),
                      )),
                ]))));
  }
}
