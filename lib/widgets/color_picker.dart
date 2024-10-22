import 'package:dreamhrms/controller/add_shift_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import 'Custom_text.dart';

Future<dynamic> colorPicker(
    {required BuildContext context, required Color controller}) async {
  Color? color = Colors.blue;
  Color? pickedColor;
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: AlertDialog(
            title: CustomText(
              text: "Color Picker",
              color: AppColors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: pickedColor ?? Colors.blue, //default color
                onColorChanged: (Color color) {
                  pickedColor = color;
                },
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    child: const Text('CANCEL'),
                    onPressed: () {
                      Navigator.of(context).pop(); //dismiss the color picker
                    },
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    child: const Text('DONE'),
                    onPressed: () {
                      if (pickedColor != null) {
                        AddShiftController.to.currentColor.value = pickedColor!;
                      }
                      Navigator.of(context).pop(); //dismiss the color picker
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
