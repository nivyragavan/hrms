import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/widgets/image_capture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';
import '../controller/common_controller.dart';

class CustomImagePicker extends StatefulWidget {
  final TextEditingController controller;
  final bool showGallery;
  final bool showCamera;

  CustomImagePicker(
      {Key? key,
      required this.controller,
      required this.showGallery,
      required this.showCamera})
      : super(key: key);

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: ThemeController.to.checkThemeCondition() == true ? AppColors.black : AppColors.lightGrey,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.grey,
              blurRadius: 5
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              ListBody(
                children: [
                  if (widget.showGallery == true)
                    ListTile(
                      onTap: () {
                        _onImageSelectedFromGallery(widget.controller);
                      },
                      title: Text("Gallery",style: TextStyle(fontSize: 15),),
                      leading: Icon(
                        Icons.photo_size_select_actual,
                        color: AppColors.snackGreen,
                      ),
                    ),
                  if ((widget.showGallery == true) &&
                      (widget.showCamera == true))
                    Divider(
                      height: 1,
                      color: AppColors.snackGreen,
                    ),
                  if (widget.showCamera == true)
                    ListTile(
                      onTap: () {
                        _onImageSelectedFromCamera();
                      },
                      title: Text("Camera",style: TextStyle(fontSize: 15),),
                      leading: Icon(
                        Icons.camera,
                        color: AppColors.snackGreen,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onImageSelectedFromCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    Get.to(ImageCapture(firstCamera));
    /*: () {
      _onImageSelected(null); // Image selection cancelled
      return true;
    });*/
  }

  void _onImageSelectedFromGallery(value) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      CommonController.to.imageLoader = true;
      widget.controller.text = pickedFile.path ?? "";
      print("picked path....${pickedFile.path}");
      CommonController.to.imageBase64 = await convertImageToBase64(pickedFile);
      print("base64Image${CommonController.to.imageBase64}");
      Get.back();
      CommonController.to.imageLoader = false;
    }
  }
}
Future<String> convertImageToBase64(XFile xFile) async {
  if (xFile != null) {
    File imageFile = File(xFile.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    print("imageBase64${base64Image}");
    return base64Image;
  }
  return '';
}
