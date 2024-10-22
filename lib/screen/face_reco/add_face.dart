import 'dart:io';
import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/face_controller.dart';
import 'package:dreamhrms/controller/theme_controller.dart';
import 'package:dreamhrms/screen/home.dart';
import 'package:dreamhrms/widgets/back_to_screen.dart';
import 'package:dreamhrms/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:face_camera/face_camera.dart';
import 'package:get/get.dart';

class AddFace extends StatefulWidget {
  const AddFace({super.key});

  @override
  State<AddFace> createState() => _AddFaceState();
}

class _AddFaceState extends State<AddFace> {
  File? _capturedImage;
  bool buttonLoader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      if (_capturedImage != null) {
        return Stack(children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                      child: Image.file(
                    _capturedImage!,
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.width * 0.7,
                    fit: BoxFit.cover,
                  )),
                  SizedBox(height: 20),
                  SizedBox(
                      width: double.infinity / 1.2,
                      child: CommonButton(
                        text: "Save This Image",
                        textColor: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        buttonLoader: buttonLoader,
                        onPressed: () async {
                          setState(() {
                            buttonLoader = true;
                          });
                          await FaceController.to
                              .addFace(filePath: _capturedImage!.path);
                          setState(() {
                            buttonLoader = false;
                          });
                          // Get.back(result: true);
                          Get.to(()=>HomeScreen());
                        },
                      )),
                  SizedBox(height: 15),
                  if (buttonLoader == false)
                    SizedBox(
                        width: double.infinity / 1.2,
                        child: BackToScreen(
                          text: "Capture Again",
                          arrowIcon: false,
                          onPressed: () =>
                              setState(() => _capturedImage = null),
                        ))
                ],
              ),
            ),
          ),
          // positioned close button on top right
          _closeButton()
        ]);
      }
      return Stack(
        children: [
          SmartFaceCamera(
              autoCapture: true,
              defaultCameraLens: CameraLens.front,
              indicatorShape: IndicatorShape.square,
              onCapture: (File? image) {
                setState(() => _capturedImage = image);
              },
              messageStyle: TextStyle(
                  color: AppColors.lightGreen, fontWeight: FontWeight.bold),
              onFaceDetected: (Face? face) {
                //Do something
              },
              showFlashControl: false,
              lensControlIcon: Icon(Icons.flip_camera_ios_outlined,
                  color: AppColors.white, size: 30),
              captureControlIcon:
                  Icon(Icons.camera_alt, color: AppColors.white, size: 50),
              messageBuilder: (context, face) {
                if (face == null || face.face == null) {
                  return _message('Place your face in the camera');
                }
                if (!face.wellPositioned) {
                  return _message('Center your face in the square');
                }
                return const SizedBox.shrink();
              }),
          // positioned close button on top right
          _closeButton()
        ],
      );
    }));
  }

  Widget _closeButton() => Positioned(
        top: 40,
        right: 20,
        child: IconButton(
          onPressed: () => Get.back(result: false),
          // onPressed: () => Get.to(()=>HomeScreen()),
          icon: Icon(Icons.close,
              color: ThemeController.to.isDarkTheme == true
                  ? AppColors.white
                  : AppColors.black),
        ),
      );

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Column(children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Hold still!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.darkGreen,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(msg,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppColors.lightOrange,
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
        ]),
      );
}
