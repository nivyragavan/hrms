import 'package:dreamhrms/controller/holiday_controller.dart';
import 'package:dreamhrms/controller/schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/common_controller.dart';
import '../employee/employee_details/profile.dart';

class HolidayCalender extends StatefulWidget {
  const HolidayCalender({
    super.key,
  });

  @override
  State<HolidayCalender> createState() => _HolidayCalenderState();
}

class _HolidayCalenderState extends State<HolidayCalender> {
  DateTime today = DateTime.now();
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  bool holidayPredicate(DateTime day) {
    final formattedDay =
        "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
    return HolidayController.to.holidayDates.contains(formattedDay);
  }

  holidayController(DateTime selectedDay, DateTime focusedDay) {
    HolidayController.to.isFromCalendar = true;
    setState(() {
      if (_selectedStartDay == null) {
        _selectedStartDay = selectedDay;
      } else if (_selectedEndDay == null) {
        if (selectedDay.isBefore(_selectedStartDay!)) {
          _selectedEndDay = _selectedStartDay;
          _selectedStartDay = selectedDay;
        } else {
          _selectedEndDay = selectedDay;
          HolidayController.to.getHolidayList();
        }
      } else {
        _selectedStartDay = selectedDay;
        _selectedEndDay = null;
      }
      HolidayController.to.fromDate.text =
          _holidayFormatDate(_selectedStartDay);
      HolidayController.to.toDate.text = _holidayFormatDate(_selectedEndDay);
    });
  }

  void onPageChanged(DateTime focusedDay) {
    int year = focusedDay.year;
    int month = focusedDay.month;
    DateTime firstDayOfMonth = DateTime(year, month, 1);
    DateTime lastDayOfMonth = DateTime(year, month + 1, 0);
    String formattedFirstDay = _holidayFormatDate(firstDayOfMonth);
    String formattedLastDay = _holidayFormatDate(lastDayOfMonth);
    HolidayController.to.fromDate.text = formattedFirstDay;
    HolidayController.to.toDate.text = formattedLastDay;
    HolidayController.to.getHolidayList();

    setState(() {
      _focusedDay = focusedDay;
    });
  }

  String _holidayFormatDate(DateTime? date) {
    final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
    return _dateFormat
        .format(date ?? DateTime.now()); // Format DateTime to String
  }

  @override
  Widget build(BuildContext context) {
    String? firstDayValue = GetStorage().read("first_day").toString();
    StartingDayOfWeek startingDayOfWeek = CommonController.to.dayToCalendar(firstDayValue ?? "monday");
    debugPrint(ScheduleController.to.isExpand.value.toString());
    return   commonLoader(
        length: 3,
        singleRow: true,
        loader: firstDayValue == "" ? true : false,
      child: TableCalendar(
        startingDayOfWeek: startingDayOfWeek,
        calendarFormat: _calendarFormat,
        focusedDay: _focusedDay,
        onPageChanged: onPageChanged,
        selectedDayPredicate: (day) {
          if (_selectedStartDay != null && _selectedEndDay != null) {
            return day.isAfter(_selectedStartDay!.subtract(Duration(days: 1))) &&
                day.isBefore(_selectedEndDay!.add(Duration(days: 1)));
          } else if (_selectedStartDay != null && _selectedEndDay == null) {
            return isSameDay(day, _selectedStartDay);
          }
          return false;
        },
        availableGestures: AvailableGestures.all,
        locale: 'en_US',
        calendarBuilders: CalendarBuilders(
          selectedBuilder: (context, date, events) {
            return Center(
              child: Container(
                height: 38,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            );
          },
          // Customize the appearance of holiday cells
          todayBuilder: (context, date, events) {
            // Use your custom styling for holiday cells here
            return Center(
              child: Container(
                height: 38,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            );
          },
          holidayBuilder: (context, date, events) {
            return Center(
              child: Container(
                height: 38,
                width: 35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            );
          },
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        calendarStyle: CalendarStyle(
          outsideDaysVisible: false,
          isTodayHighlighted: false
        ),
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        holidayPredicate: holidayPredicate,
        onDaySelected: holidayController,
      ),
    );
  }
}
