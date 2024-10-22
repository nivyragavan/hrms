import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:dreamhrms/model/asset/admin_asset_list.dart' hide State;
import 'package:dreamhrms/screen/employee/asset_details/attachment.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:skeleton_animation/skeleton_animation.dart';
import '../../constants/colors.dart';
import '../../controller/assets/add_asset_controller.dart';
import '../../controller/assets/admin_asset_controller.dart';
import '../../controller/common_controller.dart';
import '../../controller/theme_controller.dart';
import '../../widgets/Custom_rich_text.dart';
import '../../widgets/Custom_text.dart';
import '../../widgets/back_to_screen.dart';
import '../../widgets/common.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_datePicker.dart';
import '../../widgets/common_searchable_dropdown/MainCommonSearchableDropDown.dart';
import '../../widgets/common_textformfield.dart';
import '../../widgets/common_widget_icon_button.dart';
import '../main_screen.dart';
import 'admin_assets_list.dart';

class EditAsset extends StatefulWidget {
  const EditAsset({super.key});

  @override
  State<EditAsset> createState() => _EditAssetState();
}

class _EditAssetState extends State<EditAsset> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CommonController.to.buttonLoader = false;
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                  Get.to(() => MainScreen());
                },
                child: Icon(Icons.arrow_back_ios_new_outlined,
                    color: ThemeController.to.checkThemeCondition() == true ? AppColors.white : AppColors.black),
              ),
              SizedBox(width: 8),
              CustomText(
                text: "edit_assets",
                color: AppColors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 18.0,
              ),
              child:Form(
                key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: "asset_name",
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: ' *',
                            textSpanColor: AppColors.red),
                        SizedBox(
                          height: 8,
                        ),
                        CommonTextFormField(
                          controller: AddAssetController.to.assetName,
                          isBlackColors: true,
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_asset_name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomRichText(
                            textAlign: TextAlign.left,
                            text: "asset_id",
                            color: AppColors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            textSpan: ' *',
                            textSpanColor: AppColors.red),
                        SizedBox(
                          height: 8,
                        ),
                      CommonTextFormField(
                          controller: AddAssetController.to.assetID,
                          isBlackColors: true,
                          readOnly: true,
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_asset_id";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "device_categories",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CommonTextFormField(
                          controller: AddAssetController.to.deviceCategories,
                          isBlackColors: true,
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_device_categories";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "brand",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CommonTextFormField(
                          controller: AddAssetController.to.brand,
                          isBlackColors: true,
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_brand_name";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "model",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CommonTextFormField(
                          controller: AddAssetController.to.model,
                          isBlackColors: true,
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_asset_model";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "asset_status",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        AddAssetController.to.showAssetStatus
                            ? Skeleton(
                          height: 30,
                          width: Get.width,
                        )
                            : MainSearchableDropDown(
                            title: 'name',
                            isRequired: true,
                            error: "required_asset_status",
                            hint: 'select_status',
                            items: AddAssetController
                                .to.assetStatusModel?.data?.data
                                ?.map((datum) => datum.toJson())
                                .toList() ??
                                [],
                            controller: AddAssetController.to.assetStatus,
                            onChanged: (data) {
                              debugPrint(data?['name'].toString());
                              AddAssetController.to.assetStatusId =
                                  TextEditingController(
                                      text: data?['id'].toString());
                            }),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "warranty_expiration_date",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        DatePicker(
                          controller:
                          AddAssetController.to.warrantyExpirationDate,
                          hintText: 'warranty_expiration_date',
                          dateFormat: 'yyyy-MM-dd',
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_expiration_date";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "serial_number",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CommonTextFormField(
                          controller: AddAssetController.to.serialNumber,
                          isBlackColors: true,
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_serial_number";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "supplier",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CommonTextFormField(
                          controller: AddAssetController.to.supplier,
                          hintText: 'supplier_name',
                          isBlackColors: true,
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_supplier";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "purchase_date",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        DatePicker(
                          controller: AddAssetController.to.purchaseDate,
                          hintText: 'select_date',
                          dateFormat: 'yyyy-MM-dd',
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_purchase_date";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "purchase_amount",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CommonTextFormField(
                          controller: AddAssetController.to.purchaseAmount,
                          isBlackColors: true,
                          validator: (String? data) {
                            if (data!.isEmpty) {
                              return "required_purchase_amount";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 15),
                        CustomText(
                          textAlign: TextAlign.left,
                          text: "image",
                          color: AppColors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CommonController.to.imageLoader == true
                            ? Skeleton()
                            : AddAssetController.to.imageName.text != ""
                            ? InkWell(
                          onTap: () async {
                            _onImageSelectedFromGallery(
                                AddAssetController.to.imageName);
                          },
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.grey.withAlpha(40),
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: AddAssetController.to.imageName ==
                                "Network" ||
                                AddAssetController.to
                                    .isNetworkImage(
                                    AddAssetController
                                        .to.imageName.text)
                                ? Image.network(AddAssetController
                                .to.imageName.text)
                                : Image.file(
                              File(
                                AddAssetController
                                    .to.imageName.text
                                    .toString(),
                              ),
                            ),
                          ),
                        )
                            : Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            DottedBorder(
                              color: Colors.grey.withOpacity(0.5),
                              strokeWidth: 2,
                              dashPattern: [10, 6],
                              child: InkWell(
                                onTap: () {
                                  _onImageSelectedFromGallery(
                                      AddAssetController
                                          .to.imageName);
                                },
                                child: Container(
                                  height: 80,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      CustomRichText(
                                          textAlign: TextAlign.center,
                                          text:
                                          "drop_your_files_here_or"
                                              ,
                                          color: AppColors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          textSpan: 'Browser',
                                          textSpanColor:
                                          AppColors.blue),
                                      CustomText(
                                        text: "maximum_size",
                                        color: AppColors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (AddAssetController
                                .to.imageName.text ==
                                "")
                              SizedBox(height: 8),
                            CustomText(
                              text: AddAssetController
                                  .to.imageName.text,
                              color: AppColors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )
                          ],
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity / 1.2,
                          child: CommonButton(
                            text: "Save",
                            textColor: AppColors.white,
                            fontSize: 16,
                            buttonLoader: CommonController.to.buttonLoader,
                            fontWeight: FontWeight.w500,
                            onPressed: () async {
                              if (formKey.currentState?.validate() == true) {
                                CommonController.to.buttonLoader = true;
                                await AddAssetController.to.postAsset(true);
                                print("Edited");
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        BackToScreen(
                            text: "cancel",
                            arrowIcon: false,
                            onPressed: () {
                              Get.back();
                            })
                      ]),
                ),
              ),
            ),
          ),
        );
  }

  void _onImageSelectedFromGallery(controller) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CommonController.to.imageLoader = true;
      controller.text = pickedFile.path ?? "";
      AddAssetController.to.imageFormat.text = "";
      CommonController.to.imageLoader = false;
    }
  }
}
