import 'package:dreamhrms/controller/common_controller.dart';
import 'package:dreamhrms/screen/branch/add_branch_screen.dart';
import 'package:dreamhrms/screen/branch/add_branch_tabs/geo_fencing_page.dart';
import 'package:dreamhrms/screen/branch/branch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../../../constants/colors.dart';
import '../../../controller/branch_controller.dart';
import '../../../widgets/Custom_rich_text.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/back_to_screen.dart';
import '../../../widgets/common_button.dart';
import '../../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';

class GeofencingScreen extends StatelessWidget {
  GeofencingScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      BranchController.to.getBranchRadiusList();
      BranchController.to.getLatLngFromAddress();
      debugPrint(
          "Edit ${BranchController.to.isEdit == "Edit" ? "true" : "false"}");
      print("Get ${GetStorage().read("CurrentAddress").toString()}");
      print("office Address ${BranchController.to.officeAddress.text}");
    });
    return Scaffold(
      body: Obx(
        () => Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "geofencing",
                          color: AppColors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                      Switch(
                          value: BranchController.to.enableGeoFencingStatus,
                          onChanged: (value) {
                            BranchController.to.enableGeoFencingStatus = value;
                          })
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'office_address',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: AppColors.lightGrey,
                          ),
                        ),
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Get.to(() => GeoFencingPage());
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: BranchController.to.isEdit == "" && BranchController.to.officeAddress.text == ""
                              ? parseAddress(GetStorage()
                                  .read("CurrentAddress")
                                  .toString())
                              : BranchController.to.officeAddress.text != ""?
                        parseAddress(BranchController.to.officeAddress.text) : "",
                          color: AppColors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomRichText(
                      textAlign: TextAlign.left,
                      text: 'clock_in_limit(radius)',
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      textSpan: '*',
                      textSpanColor: AppColors.red),
                  BranchController.to.branchRadiusListLoader == true
                      ? Skeleton(
                          height: 30,
                          width: double.infinity,
                        )
                      : MainSearchableDropDown(
                          title: 'distance',
                          hint: "select_radius",
                          isRequired: true,
                          error: "required_radius",
                          items: BranchController.to.branchRadiusList?.data
                                  ?.map((datum) => datum.toJson())
                                  .toList() ??
                              [],
                          controller: BranchController.to.radiusController,
                          onChanged: (data) {
                            BranchController.to.radiusId.text = data['id'];
                            print(BranchController.to.radiusId.text);
                            String distance = data['distance'];
                            String numericValue =
                                distance.replaceAll(RegExp(r'[^0-9.]'), '');
                            if (double.tryParse(numericValue) != null) {
                              double radiusValue = double.parse(numericValue);
                              BranchController.to.mapLoader = true;
                              BranchController.to.radius = radiusValue;
                              BranchController.to.mapLoader = false;
                            }
                            debugPrint(BranchController.to.radius.toString());
                          }),
                  SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: BranchController.to.mapLoader == true
                        ? Skeleton(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.20,
                          )
                        : buildGoogleMap(),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Switch(
                          value: BranchController.to.allowArea,
                          onChanged: (value) {
                            BranchController.to.allowArea = value;
                          }),
                      SizedBox(
                        width: 20,
                      ),
                      CustomText(
                          text: 'allow_clock_in/out_outside_the_office',
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                            text: BranchController.to.isEdit == "" ? "create" : "save",
                            textColor: AppColors.white,
                            fontSize: 16,
                            buttonLoader: CommonController.to.buttonLoader,
                            fontWeight: FontWeight.w500,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                CommonController.to.buttonLoader = true;
                                BranchController.to.isEdit == ""?
                                await BranchController.to.postBranch(false):
                                await BranchController.to.postBranch(true);
                              }
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BackToScreen(
                    text: "cancel",
                    arrowIcon: false,
                    onPressed: () {
                      BranchController.to.isEdit = "";
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildGoogleMap() {
    debugPrint('Geo Lat ${BranchController.to.latitude.toString()}');
    debugPrint(" Geo Long ${BranchController.to.longitude.toString()}");
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: true,
      zoomGesturesEnabled: true,
      markers: {
        Marker(
            markerId: const MarkerId("1"),
            position: BranchController.to.destLocation!,
            infoWindow:
                InfoWindow(title: BranchController.to.destLocation.toString()))
      },
      circles: {
        Circle(
          circleId: const CircleId("1"),
          center: BranchController.to.destLocation!,
          radius: BranchController.to.radius,
          strokeWidth: 1,
          fillColor: AppColors.lightRed,
        )
      },
      initialCameraPosition: CameraPosition(
          target: LatLng(
              BranchController.to.latitude, BranchController.to.longitude),
          zoom: 16),
      onMapCreated: (controller) {
        _onMapCreated(controller, BranchController.to.destLocation);
      },
    );
  }

  _onMapCreated(controller, LatLng? destLocation) async {
    debugPrint(
        "Current Lat Long ${destLocation!.latitude} ${destLocation.longitude}");

    // Perform operations using the map controller
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
              destLocation.latitude,
              destLocation
                  .longitude), // Replace latitude and longitude with your desired values
          zoom: 16,
        ),
      ),
    );
  }

  String parseAddress(String fullAddress) {
    List<String> addressParts = fullAddress.split(',');

    if (addressParts.length >= 3) {
      // Extract city, state, and country
      String city = addressParts[1].trim();
      String state = addressParts[2].trim();
      String country =
          "India"; // You can set the country manually or extract it if available

      String formattedAddress = "$city, $state, $country";
      return formattedAddress;
    } else {
      return fullAddress; // Return the original address if it cannot be parsed
    }
  }
}
