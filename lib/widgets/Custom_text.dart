import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../controller/common_controller.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final TextAlign? textAlign;
  final VoidCallback? onPressed;
  final int? maxLines;
  final bool? appBar;
  CustomText({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily,
    this.textAlign,
    this.onPressed,
    this.maxLines=2,  this.appBar,
  }) : super(key: key);

  String? translatedText;

  // @override
  // Widget build(BuildContext context) {
  //   CommonController.to.commonTextLoader=true;
  //   Future.delayed(Duration.zero).then((value) async{
  //      translatedText = await CommonController.to.getTranslateKeyword(text);
  //      print("text$text translatedText$translatedText ");
  //      CommonController.to.commonTextLoader=false;
  // });
  //   return Obx(()=>
  //   CommonController.to.commonTextLoader?Skeleton(width: 10,height: 10,):
  //   InkWell(
  //       onTap: onPressed,
  //       child: Text(
  //         translatedText??"hh",
  //         textAlign: textAlign,
  //         maxLines: maxLines,
  //         softWrap: true,
  //         style: TextStyle(
  //             color: appBar == true ? Theme.of(context).textTheme.titleLarge?.color : null,
  //             fontWeight: fontWeight,
  //             fontSize: fontSize,
  //             overflow: TextOverflow.ellipsis,
  //             fontFamily: fontFamily == null ? "Inter" : fontFamily),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    CommonController.to.commonTextLoader = true;
    Future.delayed(Duration.zero).then((value) async =>
    translatedText=await CommonController.to.getTranslateKeyword(text)
    );
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
          translatedText = snapshot.data;
          CommonController.to.commonTextLoader = false;
           return InkWell(
            onTap: onPressed,
            child: Text(
              '$translatedText',
              textAlign: textAlign,
              maxLines: maxLines,
              softWrap: true,
              style: TextStyle(
                  color: appBar == true
                      ? Theme.of(context).textTheme.titleLarge?.color
                      : null,
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: fontFamily == null ? "Inter" : fontFamily),
            ),
          );
        }
      },
    );
  }
}
