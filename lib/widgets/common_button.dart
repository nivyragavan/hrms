import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../constants/colors.dart';
import '../controller/common_controller.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final VoidCallback onPressed;
  final bool? iconText;
  final IconData? icons;
  final double? iconSize;
  final bool isCancel;
  final bool? buttonLoader;
  CommonButton(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.fontSize,
      required this.fontWeight,
      this.fontFamily,
      this.textAlign,
      required this.onPressed,
      this.icons,
      this.iconText,
      this.iconSize,
      this.isCancel = false, this.buttonLoader})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: CommonController.to.getTranslateKeyword(text),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          CommonController.to.commonTextLoader = true;
          // print("Connection waiting+++++++++$text");
          return Skeleton(width: 10, height: 10);
        } else if (snapshot.hasError) {
          return Text('');
        } else {
          // translatedText = ;
          CommonController.to.commonTextLoader = false;
          return  InkWell(
            onTap: onPressed,
            child: buttonLoader==true?
            Center(
              child: SpinKitFadingCircle(
                color: AppColors.snackGreen,
                size: 50.0,
              ),
            ):Container(
              height: 44,
              decoration: BoxDecoration(
                gradient: AppColors.primaryColor1,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [],
              ),
              child: ElevatedButton(
                  onPressed: onPressed,
                  style: isCancel
                      ? ElevatedButton.styleFrom(
                    foregroundColor: AppColors.black,

                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: AppColors.grey.withOpacity(0.3),
                      ),
                    ),
                  )
                      : ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.transparent,
                    shadowColor: Colors.transparent,
                    elevation: 0,
                  ),
                  child: iconText == true
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icons, color: textColor, size: iconSize),
                      SizedBox(width: 5),
                      Text(
                        snapshot.data!,
                        textAlign: textAlign,
                        style: TextStyle(
                            color: textColor,
                            fontWeight: fontWeight,
                            fontSize: fontSize,
                            fontFamily:
                            fontFamily == null ? "Inter" : fontFamily),
                      ),
                    ],
                  )
                      : Text(
                    snapshot.data!,
                    textAlign: textAlign,
                    style: TextStyle(
                        color: textColor,
                        fontWeight: fontWeight,
                        fontSize: fontSize,
                        fontFamily: fontFamily == null ? "Inter" : fontFamily),
                  )),
            ),
          );
        }
      },
    );
    // return  InkWell(
    //   onTap: onPressed,
    //   child: buttonLoader==true?
    //   Center(
    //     child: SpinKitFadingCircle(
    //       color: AppColors.snackGreen,
    //       size: 50.0,
    //     ),
    //   ):Container(
    //     height: 44,
    //     decoration: BoxDecoration(
    //       gradient: AppColors.primaryColor1,
    //       borderRadius: BorderRadius.circular(8),
    //       boxShadow: [],
    //     ),
    //     child: ElevatedButton(
    //         onPressed: onPressed,
    //         style: isCancel
    //             ? ElevatedButton.styleFrom(
    //           foregroundColor: AppColors.black,
    //
    //           elevation: 0,
    //           shadowColor: Colors.transparent,
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(8.0),
    //             side: BorderSide(
    //               color: AppColors.grey.withOpacity(0.3),
    //             ),
    //           ),
    //         )
    //             : ElevatedButton.styleFrom(
    //           primary: Colors.transparent,
    //           onPrimary: Colors.transparent,
    //           shadowColor: Colors.transparent,
    //           elevation: 0,
    //         ),
    //         child: iconText == true
    //             ? Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Icon(icons, color: textColor, size: iconSize),
    //             SizedBox(width: 5),
    //             Text(
    //               CommonController.to.getTranslateKeyword(text),
    //               textAlign: textAlign,
    //               style: TextStyle(
    //                   color: textColor,
    //                   fontWeight: fontWeight,
    //                   fontSize: fontSize,
    //                   fontFamily:
    //                   fontFamily == null ? "Inter" : fontFamily),
    //             ),
    //           ],
    //         )
    //             : Text(
    //           CommonController.to.getTranslateKeyword(text),
    //           textAlign: textAlign,
    //           style: TextStyle(
    //               color: textColor,
    //               fontWeight: fontWeight,
    //               fontSize: fontSize,
    //               fontFamily: fontFamily == null ? "Inter" : fontFamily),
    //         )),
    //   ),
    // );
  }
// var translateSave;
//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration.zero).then((value) async {
//       translateSave = await CommonController.to.getTranslateKeyword(text);
//       print("translateSave$translateSave");
//     });
//     return InkWell(
//       onTap: onPressed,
//       child: buttonLoader==true?
//       Center(
//         child: SpinKitFadingCircle(
//           color: AppColors.snackGreen,
//           size: 50.0,
//         ),
//       ):Container(
//         height: 44,
//         decoration: BoxDecoration(
//           gradient: AppColors.primaryColor1,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [],
//         ),
//         child: ElevatedButton(
//             onPressed: onPressed,
//             style: isCancel
//                 ? ElevatedButton.styleFrom(
//                     foregroundColor: AppColors.black,
//
//                     elevation: 0,
//                     shadowColor: Colors.transparent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                       side: BorderSide(
//                         color: AppColors.grey.withOpacity(0.3),
//                       ),
//                     ),
//                   )
//                 : ElevatedButton.styleFrom(
//                     primary: Colors.transparent,
//                     onPrimary: Colors.transparent,
//                     shadowColor: Colors.transparent,
//                     elevation: 0,
//                   ),
//             child: iconText == true
//                 ? Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(icons, color: textColor, size: iconSize),
//                       SizedBox(width: 5),
//                       Text(
//                         translateSave,
//                         textAlign: textAlign,
//                         style: TextStyle(
//                             color: textColor,
//                             fontWeight: fontWeight,
//                             fontSize: fontSize,
//                             fontFamily:
//                                 fontFamily == null ? "Inter" : fontFamily),
//                       ),
//                     ],
//                   )
//                 : Text(
//                     text,
//                     textAlign: textAlign,
//                     style: TextStyle(
//                         color: textColor,
//                         fontWeight: fontWeight,
//                         fontSize: fontSize,
//                         fontFamily: fontFamily == null ? "Inter" : fontFamily),
//                   )),
//       ),
//     );
//   }
}
