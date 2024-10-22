import 'package:flutter/cupertino.dart';



class ClockData {
  ClockData({
    required this.days,
    required this.startTime,
    required this.endTime,
    required this.breakTime,
    this.active = false,
  });
  final String days;
  final TextEditingController startTime;
  final TextEditingController endTime;
  final TextEditingController breakTime;
   bool active;
}


class DurationDataModel {
  DurationDataModel({
    required this.shiftName,
     this.color,
     this.type,
     this.shiftType,
    required this.shiftHours,
    required this.durationData,
  });
  final List<DurationData> durationData;
  final String shiftName;
  final String? color;
  final String? type;
  final String? shiftType;
  final String shiftHours;
}

class ClockDataModel {
  ClockDataModel({
    required this.shiftName,
     this.color,
     this.type,
     this.shiftType,
    required this.shiftHours,
    required this.clockDataModel,
  });
  final List<ClockData> clockDataModel;
  final String shiftName;
  final String? color;
  final String? type;
  final String? shiftType;
  final String shiftHours;
}

class DurationData {
  DurationData({
    required this.days,
    required this.duration,
    this.active = false,
  });
  final String days;
  final TextEditingController duration;
  bool active;
}