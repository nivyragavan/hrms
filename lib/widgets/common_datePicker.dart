import 'package:dreamhrms/controller/common_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController controller;
  final BorderSide? focusedBorder;
  final BorderSide? disabledBorder;
  final BorderSide? enabledBorder;
  final String? hintText;
  final String dateFormat;
  final bool? filled;
  final Color? fillColor;
  final String? errorText;
  final bool? showPicker;
  final bool? displayCurrentDate;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  DatePicker(
      {Key? key,
      required this.controller,
      this.focusedBorder,
      this.fillColor,
      this.enabledBorder,
      this.disabledBorder,
       this.hintText,
      required this.dateFormat,
      this.onSaved,
      this.errorText,
      this.validator,
      this.displayCurrentDate = false,
      this.showPicker = true, this.filled});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.displayCurrentDate == true
        ? widget.controller.text =
            CommonController.to.formatDate('${DateFormat("yyyy-MM-dd").format(DateTime.now())}')
        : "";
    print("displayCurrentDate${widget.displayCurrentDate}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8),
            isDense: false,
            filled: widget.filled,
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: AppColors.lightGrey, width: 1.7),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.lightGrey, width: 1),
            ),
            hintText: widget.displayCurrentDate == true
                ? widget.controller.text
                : GetStorage().read("date_format").toString(),
            errorText: widget.errorText,
            hintStyle: TextStyle(fontSize: 14, color: AppColors.grey),
            suffixIcon: const Icon(
              Icons.calendar_today_outlined,
              size: 14,
              // color: Colors.black,
            )),
        readOnly: true,
        onSaved: widget.onSaved,
        onTap: () async {
          if (widget.showPicker == true) {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(3000));
            if (pickedDate != null) {
              print(pickedDate);
              String format='yyyy-MM-dd';
              String formattedDate =
                  DateFormat(format).format(pickedDate);
              print("formattedDate$formattedDate");
              setState(() {
                widget.controller.text = CommonController.to.dateConversion(formattedDate,GetStorage().read('date_format'));
                print("Controller text ${widget.controller.text}");
              });
              if (widget.onSaved != null) {
                widget.onSaved!(formattedDate);
              }
            } else {
              print("Date is not selected");
            }
          }
        },
      ),
    );
  }
}
