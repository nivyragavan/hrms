// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../colors.dart';
//
// class CommonTimePicker extends StatefulWidget {
//   final TextEditingController controller;
//   final  BorderSide focusedBorder;
//   final  BorderSide disabledBorder;
//   final  BorderSide enabledBorder;
//   final String hintText;
//   final String timeFormat;
//   CommonTimePicker({Key? key, required this.controller,  this.focusedBorder = const BorderSide(color: Colors.grey,width: 1.7),this.enabledBorder = const BorderSide(color: Colors.grey,width: 1), this.disabledBorder= const BorderSide(color: Colors.black,width: 1.7), required this. hintText, required this.timeFormat});
//
//   @override
//   State<CommonTimePicker> createState() => _CommonTimePickerState();
// }
//
// class _CommonTimePickerState extends State<CommonTimePicker> {
//   String? hour, minute, time;
//   TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: TextFormField(
//         controller:widget.controller,
//         decoration: InputDecoration(
//             contentPadding: const EdgeInsets.all(15),
//             isDense: false,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5),
//               borderSide:
//               widget.focusedBorder,
//             ),
//             disabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide:
//               widget.disabledBorder
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(8),
//               borderSide:
//              widget.enabledBorder
//             ),
//             hintText: 'Select Shift Time',
//             hintStyle: TextStyle(fontSize: 14, color: AppColors.grey),
//             suffixIcon: const Icon(
//               Icons.access_time_outlined,
//               size: 18,
//               color: Colors.black,
//             )),
//         readOnly: true,
//         onTap: () async {
//           TimeOfDay? picked = await showTimePicker(
//             context: context,
//             initialTime: selectedTime,
//             // use24HourFormat: true,
//             // showSecondsColumn: true,
//           );
//           if (picked != null) {
//             setState(() {
//               // selectedTime = picked;
//               // hour = selectedTime.hour.toString();
//               // minute = selectedTime.minute.toString();
//               // time = '${hour!} : ${minute!}';
//               // EmployeeController.to.shiftTimeController.text = time!;
//               String formattedTime =
//               picked.format(context).toString();
//               widget.controller.text =
//                   formattedTime;
//             });
//           } else {
//             print("Time is not selected");
//           }
//         },
//         validator: (value) {
//           if (value!.isEmpty) {
//             return 'Enter a valid to time';
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }

import 'package:dreamhrms/controller/common_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';

class CommonTimePicker extends StatefulWidget {
  final TextEditingController controller;
  final BorderSide? focusedBorder;
  final BorderSide? disabledBorder;
  final BorderSide? enabledBorder;
  final String? hintText;
  final String? timeFormat;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final bool? readOnly;
  final bool? suffixIcon;
  final bool? contentPadding;
  CommonTimePicker({
    Key? key,
    required this.controller,
    this.focusedBorder,
    this.enabledBorder,
    this.disabledBorder,
    this.onSaved,
    this.onChanged,
     this.hintText,
     this.timeFormat,
    this.validator,

    this.readOnly = false,
    this.suffixIcon,
    this.contentPadding,
  });

  @override
  State<CommonTimePicker> createState() => _CommonTimePickerState();
}



class _CommonTimePickerState extends State<CommonTimePicker> {
  String? hour, minute, time;
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  String  format = "";

  // String convertTo24HourFormat1(String time12Hr) {
  //   TimeOfDay timeOfDay = TimeOfDay(
  //     hour: int.parse(time12Hr.split(':')[0]),
  //     minute: int.parse(time12Hr.split(':')[1].split(' ')[0]),
  //   );
  //   final now = DateTime.now();
  //   final dateTime = DateTime(
  //     now.year,
  //     now.month,
  //     now.day,
  //     timeOfDay.hour,
  //     timeOfDay.minute,
  //   );
  //   final format = DateFormat(widget.timeFormat);
  //   print("after conversion of 24 hours ${format.format(dateTime)}");
  //   return format.format(dateTime);
  // }


 @override
 void initState() {
   super.initState();
   String format = GetStorage().read("global_time").toString();
   print("Format ${GetStorage().read("global_time").toString()}");
   if (format != null) {
     List<String> timeParts = format.split(':');
     if (timeParts.length >= 2) {
       int hour = int.tryParse(timeParts[0]) ?? 0;
       int minute = int.tryParse(timeParts[1]) ?? 0;
       String amPm = "";
       if (timeParts.length == 3) {
         amPm = timeParts[2].toLowerCase();
       }
       if (amPm == "a" || amPm == "p") {
         if (amPm == "p" && hour < 12) {
           hour += 12;
         }
       } else {
         if (hour >= 24 || minute >= 60) {
           print("Invalid time format: $format");
         }
       }
       selectedTime = TimeOfDay(hour: hour, minute: minute);
       print(selectedTime);
     } else {
       print("Invalid time format: $format");
     }
   } else {
     print("The 'global_time' key does not exist in storage.");
   }
 }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            contentPadding: widget.contentPadding == false
                ? const EdgeInsets.all(3)
                : const EdgeInsets.all(15),
            isDense: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
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
            hintText: GetStorage().read("global_time").toString(),
            hintStyle: TextStyle(fontSize: 14, color: AppColors.grey),
            suffixIcon: widget.suffixIcon == true
                ? const Icon(
                    Icons.access_time_outlined,
                    size: 18,
                    // color: Colors.black,
                  )
                : null,
          ),
          readOnly: true,
          onSaved: widget.onSaved,
          onTap: () async {
            if (widget.readOnly == false) {
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: selectedTime,
                //use24HourFormat: true,
                // showSecondsColumn: true,

              );
              if (picked != null) {
                String formattedTime = picked.format(context).toString();
                print("formatted time $formattedTime");
                setState(() {
                widget.controller.text =
                    CommonController.to.timeConversion(formattedTime, widget.timeFormat.toString());
                });
                if (widget.onSaved != null) {
                  widget.onSaved!(formattedTime);
                }
              } else {
                print("Time is not selected");
              }
            }
          },
          validator: widget.validator),
    );
  }
}
