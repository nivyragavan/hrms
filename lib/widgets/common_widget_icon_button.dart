import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CommonIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon icon;
  final double height;
  final double width;
  const CommonIconButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onPressed,
      child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            gradient: AppColors.primaryColor1,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [],
          ),
          child: icon
        /*ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
              ),
              child: icon)*/
      ),
    );
  }
}
