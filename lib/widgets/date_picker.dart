import 'package:dreamhrms/controller/employee_details_controller/time_sheet_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../constants/colors.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {


  @override
  void initState() {
    super.initState();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        // TimeSheetController.to.date.clear();
        TimeSheetController.to.date.insert(
            0,
            "${DateFormat.y().format(args.value.startDate).toString()}-${DateFormat.M().format(args.value.startDate).toString().padLeft(2, '0')}-"
            "${DateFormat.d().format(args.value.startDate ?? args.value.startDate).toString().padLeft(2, '0')}");
        TimeSheetController.to.date.insert(
            1,
            "${DateFormat.y().format(args.value.endDate ?? args.value.startDate).toString()}-${DateFormat.M().format(args.value.endDate ?? args.value.startDate).toString().padLeft(2, '0')}-"
            "${DateFormat.d().format(args.value.endDate ?? args.value.startDate).toString().padLeft(2, '0')}");
        TimeSheetController.to.attendanceStartDate =
            "${DateFormat.y().format(args.value.startDate).toString()}-${DateFormat.M().format(args.value.startDate).toString().padLeft(2, '0')}-"
            "${DateFormat.d().format(args.value.startDate ?? args.value.startDate).toString().padLeft(2, '0')}";
        TimeSheetController.to.attendanceEndDate =
            "${DateFormat.y().format(args.value.endDate ?? args.value.startDate).toString()}-${DateFormat.M().format(args.value.endDate ?? args.value.startDate).toString().padLeft(2, '0')}-"
            "${DateFormat.d().format(args.value.endDate ?? args.value.startDate).toString().padLeft(2, '0')}";
        TimeSheetController.to.attendanceDate =
            DateFormat.d().format(args.value.startDate).toString() +
                " " +
                DateFormat.LLL().format(args.value.startDate).toString() +
                ' - ' +
                DateFormat.d()
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString() +
                " " +
                DateFormat.LLL()
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString() +
                " " +
                DateFormat.y()
                    .format(args.value.endDate ??
                        args.value.endDate ??
                        args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
      } else if (args.value is List<DateTime>) {

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> startDateComponents =
        TimeSheetController.to.attendanceStartDate.split("-");
    List<String> endDateComponents =
        TimeSheetController.to.attendanceEndDate.split("-");
     return Scaffold(
      body: Column(
        children: [
          SfDateRangePicker(
            onSelectionChanged: _onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            confirmText: "OK",
            cancelText: "OK",
             initialSelectedRange: PickerDateRange(
                DateTime(
                    int.parse(startDateComponents[0]),
                    int.parse(startDateComponents[1]),
                    int.parse(startDateComponents[2])),
                DateTime(
                    int.parse(endDateComponents[0]),
                    int.parse(endDateComponents[1]),
                    int.parse(endDateComponents[2]))),
          )
        ],
      ),
    );
  }
}
