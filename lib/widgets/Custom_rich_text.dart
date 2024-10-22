import 'package:flutter/material.dart';
import 'package:skeleton_animation/skeleton_animation.dart';

import '../controller/common_controller.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final String? textSpan;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final TextAlign textAlign;
  final Color? textSpanColor;
  final double? textSpanFontSize;
  final FontWeight? textSpanFontWeight;
  final String? textSpanFontFamily;
  final TextAlign? textSpanTextAlign;
  final VoidCallback? onPressed;
  CustomRichText({
    Key? key,
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    this.fontFamily,
    required this.textAlign,
     this.textSpan,
     this.textSpanColor,
     this.textSpanFontSize,
     this.textSpanFontWeight,
    this.textSpanFontFamily,
    this.textSpanTextAlign, this.onPressed,
  }) : super(key: key);
  String? translatedText;
  @override
  Widget build(BuildContext context) {
    // CommonController.to.commonTextLoader = true;
    // Future.delayed(Duration.zero).then((value) async =>translatedText=await CommonController.to.getTranslateKeyword(text));
    return FutureBuilder<String>(
      future: CommonController.to.getTranslateKeyword(text),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          CommonController.to.commonTextLoader = true;
          // print("Connection waiting+++++++++$text");
          return Skeleton(width: 10, height: 10);
        } else if (snapshot.hasError) {
          // print("Translator error occur ++++++++++++$text ${'Error: ${snapshot.error}'}");
          return Text('');
        } else {
          translatedText = snapshot.data;
          // print("Connection execeuted+++++++++$text $translatedText");
          CommonController.to.commonTextLoader = false;
          // Future.delayed(Duration(seconds: 1)).then((value) =>  CommonController.to.commonTextLoader = false);
          return CommonController.to.commonTextLoader?Skeleton(width: 10, height: 10):
          InkWell(
            onTap: onPressed,
            child: RichText(
              textAlign: textAlign,
              text: TextSpan(
                  children: [
                    TextSpan(
                      text: translatedText,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleLarge?.color,
                          fontWeight: fontWeight,
                          fontSize: fontSize,
                          fontFamily: fontFamily == null ? "Inter" : fontFamily),
                    ),
                    TextSpan(
                      text: " $textSpan",
                      style: TextStyle(
                          color: textSpanColor,
                          fontWeight: textSpanFontWeight,
                          fontSize: textSpanFontSize,
                          fontFamily: textSpanFontFamily == null ? "Inter" : textSpanFontFamily),
                    ),
                  ]),
            ),
          );
        }
      },
    );
  }
}
