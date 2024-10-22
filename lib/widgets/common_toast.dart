import 'package:flutter/material.dart';
import '../constants/colors.dart';

void showToast(BuildContext? context, String message, String? toastType) {
  if (context != null) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
              fontSize: 12,
              color: AppColors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
        ),
        backgroundColor:
            toastType == "success" ? AppColors.green : AppColors.red,
      ),
    );
  }
}
