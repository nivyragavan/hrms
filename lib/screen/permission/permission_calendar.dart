import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/colors.dart';
import '../../controller/permission_controller.dart';

class PermissionCalendar extends StatefulWidget {
  const PermissionCalendar({Key? key}) : super(key: key);

  @override
  State<PermissionCalendar> createState() => _PermissionCalendarState();
}

class _PermissionCalendarState extends State<PermissionCalendar> {


  DateTime today = DateTime.now();
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;

  @override
  Widget build(BuildContext context) {
    return calendar();
  }

  Obx calendar(){
    return Obx(() {
      return Column(
        children: [
          TableCalendar(
            calendarFormat: PermissionController.to.isExpand
                ? CalendarFormat.month
                : CalendarFormat.week,
            focusedDay:   _selectedStartDay ?? DateTime.now(),
            selectedDayPredicate: (day) {
              if (_selectedStartDay != null && _selectedEndDay != null) {
                return day.isAfter(_selectedStartDay!.subtract(Duration(days: 1))) &&
                    day.isBefore(_selectedEndDay!.add(Duration(days: 1)));
              } else if (_selectedStartDay != null && _selectedEndDay == null) {
                return isSameDay(day, _selectedStartDay);
              }
              final DateTime now = DateTime.now();
              final DateTime nextFourDays = now.add(Duration(days: 6));
              return day.isAfter(now) && day.isBefore(nextFourDays);
              return false;
            },
            availableGestures: AvailableGestures.all,
            locale: 'en_US',
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            onDaySelected: _onSelected,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue, // Change this to your desired color
              ),
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue, // Change this to your desired color
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              PermissionController.to.isExpand =
                  !PermissionController.to.isExpand;
            },
            icon: Icon(
              PermissionController.to.isExpand
                  ? Icons.expand_less
                  : Icons.expand_more,
              size: 24,
              color: AppColors.grey,
            ),
          ),
        ],
      );
    });
  }

  void _onSelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
      if (_selectedStartDay == null) {
        _selectedStartDay = selectedDay;
      } else if (_selectedEndDay == null) {
        if (selectedDay.isBefore(_selectedStartDay!)) {
          _selectedEndDay = _selectedStartDay;
          _selectedStartDay = selectedDay;
          print("start date $_selectedStartDay");
          print("end date $_selectedEndDay");
        } else {
          _selectedEndDay = selectedDay;
          PermissionController.to.getPermissionHistory();
          PermissionController.to.isExpand = false;
        }
      } else {
        _selectedStartDay = selectedDay;
        _selectedEndDay = null;
      }
      PermissionController.to.fromDateFilter.text =
          _leaveFormatDate(_selectedStartDay);
      PermissionController.to.toDateFilter.text =
          _leaveFormatDate(_selectedEndDay);
      print("from date ${PermissionController.to.fromDateFilter.text}");
      print("to date ${PermissionController.to.toDateFilter.text}");
    });
  }

  String _leaveFormatDate(DateTime? date) {
    final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
    debugPrint(_dateFormat.format(date ?? DateTime.now()));
    return _dateFormat
        .format(date ?? DateTime.now()); // Format DateTime to String
  }
}
