import 'package:dreamhrms/constants/colors.dart';
import 'package:dreamhrms/controller/leave_controller.dart';
import 'package:dreamhrms/controller/schedule_controller.dart';
import 'package:dreamhrms/model/schedue_datewise_model.dart';
import 'package:dreamhrms/screen/employee/employee_details/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../controller/attendance/employee_attendance_controller.dart';
import '../../controller/common_controller.dart';

class Calender extends StatefulWidget {
  final bool isSingleDate;
  final int? day;
  final  String? type;
  const Calender({super.key, this.isSingleDate = false,  this.day=4, this.type});

  @override
  State<Calender> createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  DateTime today = DateTime.now();
  DateTime? _selectedStartDay;
  DateTime? _selectedEndDay;
  ScheduleDateWiseModel scheduleDateWiseModel = ScheduleDateWiseModel(
    firstData: [], // Initialize the list with an empty list
    secondData: [],
    thirdData: [],
    fourData: [],
  );
  @override
  void initState() {
    super.initState();
  }

  _onSelected(DateTime selectedDay, DateTime focusedDay) {
    if (widget.isSingleDate == false) {
      if(widget.type=="attendance")  {
        print("current date $selectedDay");
        EmployeeAttendanceController.to.fromDateController.text =
            _leaveFormatDate(selectedDay);
        EmployeeAttendanceController.to.toDateController.text=DateFormat('yyyy-MM-dd').format(selectedDay.add(Duration(days: 7)));
        print("calendar ${EmployeeAttendanceController.to.fromDateController.text} to date ${EmployeeAttendanceController.to.toDateController.text}");
        EmployeeAttendanceController.to.employeeAttendanceLoader=true;
        Future.delayed(Duration.zero).then((value) async {
          await EmployeeAttendanceController.to.getEmployeeAttendanceList(type:"2");
        });
        LeaveController.to.isExpand = false;
      }else{
        ScheduleController.to.dateList.clear();
        ScheduleController.to.dateApiFormat.clear();
        final DateFormat _format = DateFormat('dd-MM-yy');
        final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
        ScheduleController.to.dateList.add(
            _dateFormat.format(today)); // Convert DateTime to formatted string
        ScheduleController.to.dateApiFormat
            .add(_format.format(today)); // Convert DateTime to formatted string
        for (int i = 1; i <= 4; i++) {
          DateTime nextDay = today.add(Duration(days: i));
          ScheduleController.to.dateList.add(_dateFormat.format(nextDay));
          ScheduleController.to.dateApiFormat.add(_format.format(nextDay));
        }
        Future.delayed(Duration.zero).then((value) async {
          ScheduleController.to.scheduleLoader = true;
          // await ScheduleController.to.getDataList();
          await ScheduleController.to.getScheduleList();
          scheduleDateWiseModel = ScheduleDateWiseModel(
            firstData: [], // Initialize the list with an empty list
            secondData: [],
            thirdData: [],
            fourData: [],
          );
          await ScheduleController.to.getFilteredList(
              ScheduleController.to.scheduleListModel, scheduleDateWiseModel);
          ();
          ScheduleController.to.scheduleLoader = false;
        });
      }
    }
    else {
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
          LeaveController.to.getLeaveHistory();
          LeaveController.to.isExpand = false;
        }
      } else {
        _selectedStartDay = selectedDay;
        _selectedEndDay = null;
      }
      LeaveController.to.fromDateFilter.text =
          _leaveFormatDate(_selectedStartDay);
      LeaveController.to.toDateFilter.text =
          _leaveFormatDate(_selectedEndDay);
    }
    setState(()  {
      print(selectedDay);
      print("DateTime selectedDay$selectedDay${widget.isSingleDate} key ${widget.key}");
      today = selectedDay;
    });
  }

  String _leaveFormatDate(DateTime? date) {
    final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
    debugPrint(_dateFormat.format(date ?? DateTime.now()));
    return _dateFormat
        .format(date ?? DateTime.now()); // Format DateTime to String
  }

  String _formatDate(DateTime date) {
    final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
    debugPrint(_dateFormat.format(date));
    return _dateFormat.format(date); // Format DateTime to String
  }

  @override
  Widget build(BuildContext context) {
    String? firstDayValue = GetStorage().read("first_day").toString();
    print("First Day Value ${firstDayValue}");
    StartingDayOfWeek startingDayOfWeek = CommonController.to.dayToCalendar(firstDayValue);
    print("Starting of value ${startingDayOfWeek}");
    return widget.isSingleDate
        ? Obx(()  {
            return Column(
              children: [
                commonLoader(
                  length: 3,
                  singleRow: true,
                  loader: firstDayValue == "" ? true : false,
                  child: TableCalendar(
                    startingDayOfWeek: startingDayOfWeek,
                    calendarFormat: LeaveController.to.isExpand
                        ? CalendarFormat.month
                        : CalendarFormat.week,
                    focusedDay: _selectedStartDay ?? DateTime.now(),
                    selectedDayPredicate: (day) {
                      if (_selectedStartDay != null && _selectedEndDay != null) {
                        return day.isAfter(
                                _selectedStartDay!.subtract(Duration(days: 1))) &&
                            day.isBefore(_selectedEndDay!.add(Duration(days: 1)));
                      } else if (_selectedStartDay != null &&
                          _selectedEndDay == null) {
                        return isSameDay(day, _selectedStartDay);
                      }
                      final DateTime now = DateTime.now();
                      final DateTime nextFourDays = now.add(Duration(days: 6));
                      return day.isAfter(now) && day.isBefore(nextFourDays);
                      // return false;
                    },
                    availableGestures: AvailableGestures.all,
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
                    locale: 'en_US',
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    firstDay: DateTime.utc(2010, 10, 16),

                    lastDay: DateTime.utc(2030, 3, 14),
                    onDaySelected: _onSelected,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    LeaveController.to.isExpand = !LeaveController.to.isExpand;
                  },
                  icon: Icon(
                    LeaveController.to.isExpand
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 24,
                    color: AppColors.grey,
                  ),
                ),
              ],
            );
          })
        : Obx(
            () => Column(
              children: [
              commonLoader(
              length: 3,
              singleRow: true,
              loader: firstDayValue == "" ? true : false,
                  child: TableCalendar(
                    startingDayOfWeek:startingDayOfWeek,
                    calendarFormat: ScheduleController.to.isExpand.value
                        ? CalendarFormat.month
                        : CalendarFormat.week,
                    focusedDay: today,
                    calendarStyle: CalendarStyle(
                      outsideDaysVisible: false,
                      rangeHighlightColor: Colors.transparent,
                      todayDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue, // Change this to blue
                      ),
                      selectedDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue, // Change this to blue
                      ),
                      rangeStartDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: AppColors.black,
                      ),
                      rangeEndDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      withinRangeDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      rangeEndTextStyle: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    selectedDayPredicate: (day) => isSameDay(day, today),
                    availableGestures: AvailableGestures.all,
                    locale: 'en_US',
                    calendarBuilders: CalendarBuilders(
                      withinRangeBuilder: (context, date, events) {
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
                                style:
                                    TextStyle(color: Colors.white, fontSize: 15),
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
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    onDaySelected: _onSelected,
                    //rangeSelectionMode: RangeSelectionMode.disabled,
                    rangeStartDay: today,
                    rangeEndDay: today.add(Duration(days: widget.day!.toInt())),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ScheduleController.to.isExpand.toggle();
                  },
                  icon: Icon(
                    Icons.expand_more,
                    size: 24,
                    color: AppColors.grey,
                  ),
                ),
              ],
            ),
          );
  }
}
