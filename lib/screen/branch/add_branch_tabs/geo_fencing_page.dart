import 'package:dreamhrms/controller/branch_controller.dart';
import 'package:dreamhrms/screen/branch/add_branch_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:localization/localization.dart';
import '../../../constants/colors.dart';
import '../../../model/branch_model/address_model.dart';
import '../../../model/branch_model/placePredictaion_model.dart';
import '../../../widgets/Custom_text.dart';
import '../../../widgets/common_textformfield.dart';
import '../../../services/location_service.dart';

class GeoFencingPage extends StatefulWidget {
  const GeoFencingPage({super.key});

  @override
  State<GeoFencingPage> createState() => _GeoFencingPageState();
}

class _GeoFencingPageState extends State<GeoFencingPage> {
  final dropLocation = TextEditingController();

  List<PlacePredictionModel> placePrediction = [];
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
            InkWell(
              onTap: () {
                Get.to(
                  () => AddBranchScreen(
                    index: 1,
                  ),
                );
              },
              child: Icon(Icons.arrow_back_ios_new_outlined,
                  color: AppColors.black),
            ),
            SizedBox(width: 8),
            CustomText(
              text: "choose_location",
              color: AppColors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              GestureDetector(
                onTap: () {},
                child: CommonTextFormField(
                  controller: dropLocation,
                  isBlackColors: true,
                  hintText: "enter_office_address",
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    findPlace(value);
                  },
                ),
              ),
              const SizedBox(height: 15),
              placePrediction.isEmpty
                  ? Container()
                  : ListView.separated(
                      itemCount: placePrediction.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const Icon(Icons.location_on),
                          title: Text('${placePrediction[index].mainText}'),
                          subtitle:
                              Text('${placePrediction[index].secondaryText}'),
                          onTap: () {
                            setState(() {
                              dropLocation.text =
                                  placePrediction[index].mainText!;
                            });
                            print("dropLocationController${dropLocation.text}");
                            GetStorage().write("CurrentAddress", "");
                            print(
                                "Removed ${GetStorage().read("CurrentAddress").toString()}");
                            getPlaceDetails(
                                context, placePrediction[index].placeId!);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    )
            ],
          ),
        ),
      ),
    );
  }

  ///get place list on type
  void findPlace(String placeName) async {
    if (placeName.length > 1) {
      String autoCompleteUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=AIzaSyDa3ndOn9kcJhiJqKBwi6D9WLwO_mH-_tM&components=country:in";
      final response = await LocationService().getRequest(autoCompleteUrl);
      if (response == 'failed') {
        return;
      }
      if (response["status"] == "OK") {
        var predictions = response["predictions"];
        var placesList = (predictions as List)
            .map((e) => PlacePredictionModel.fromJson(e))
            .toList();
        setState(() {
          placePrediction = placesList;
          // dropLocationController.text = response["predictions"][0]["description"];
          debugPrint("Place Name ${placeName}");
          debugPrint("current Address ${dropLocation.text}");
        });
      }
    }
  }

  ///show picked place details
  void getPlaceDetails(BuildContext context, String placeId) async {
    String placeDetailsUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyDa3ndOn9kcJhiJqKBwi6D9WLwO_mH-_tM';

    final response = await LocationService().getRequest(placeDetailsUrl);

    if (response == "failed") {
      return;
    }
    if (response["status"] == "OK") {
      AddressModel addressModel = AddressModel();
      addressModel.placeId = placeId;
      addressModel.placeName = response["result"]["name"];
      addressModel.latitude = response["result"]["geometry"]["location"]["lat"];
      addressModel.longitude =
          response["result"]["geometry"]["location"]["lng"];

      print("this is your office location ${addressModel.placeName}");
      print("office lat :${addressModel.latitude}");
      print("office long :${addressModel.longitude}");

      BranchController.to.officeAddress.text = response["result"]["name"];
      print(  BranchController.to.officeAddress.text );
      BranchController.to.latitude = addressModel.latitude!.toDouble();
      debugPrint("Ctrl lat ${BranchController.to.latitude.toString()}");
      BranchController.to.longitude = addressModel.longitude!.toDouble();
      debugPrint("Ctrl long ${BranchController.to.longitude.toString()}");
      BranchController.to.destLocation =
          LatLng(BranchController.to.latitude, BranchController.to.longitude);
      Get.to(() => AddBranchScreen(
            index: 1,
          ));
      // Get.back(result: "obtainDirection");
    }
  }
}
