import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../constants/colors.dart';
import 'Custom_rich_text.dart';
import 'Custom_text.dart';


class PickedImageErrorSizeWidget extends StatelessWidget {
  final VoidCallback onPressed;
  const PickedImageErrorSizeWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedBorder(
          color: Colors.grey.withOpacity(0.5),
          strokeWidth: 2,
          dashPattern: [10, 6],
          child: InkWell(
            onTap: onPressed,
            child: Container(
              height: 80,
              width: double.infinity,
              child: Column(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  CustomRichText(
                      textAlign: TextAlign.center,
                      text: "Drop your image here or"
                          ,
                      color: AppColors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      textSpan: 'Browser',
                      textSpanColor: AppColors.blue),
                  SizedBox(height: 10),
                  CustomText(
                    text: "Maximum size: 50MB",
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        CustomText(
          text: "Image should be less than 50MB",
          color: Colors.red.shade800,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}
