class ScheduleDateWiseModel {
  final List<FirstData>? firstData;
  final List<FirstData>? secondData;
  final List<FirstData>? thirdData;
  final List<FirstData>? fourData;

  ScheduleDateWiseModel({
     this.firstData,
     this.secondData,
     this.thirdData,
     this.fourData,
  });

  factory ScheduleDateWiseModel.fromJson(Map<String, dynamic> json) {
    return ScheduleDateWiseModel(
      firstData: List<FirstData>.from(json['first_data'].map((data) => FirstData.fromJson(data))),
      secondData: List<FirstData>.from(json['second_data'].map((data) => FirstData.fromJson(data))),
      thirdData: List<FirstData>.from(json['third_data'].map((data) => FirstData.fromJson(data))),
      fourData: List<FirstData>.from(json['four_data'].map((data) => FirstData.fromJson(data))),
    );
  }
}

class FirstData {
  final String day;
  final String date;
  final String id;
  final String shiftId;
  final String shiftName;
  final String shiftColor;
  final String shiftHours;
  final String shiftType;
  final String shiftStartTime;
  final String shiftEndTime;
  final String shiftBreakTime;
  final String duration;
  final String imageSrc;

  FirstData({
    required this.day,
    required this.date,
    required this.id,
    required this.shiftId,
    required this.shiftName,
    required this.shiftColor,
    required this.shiftHours,
    required this.shiftType,
    required this.shiftStartTime,
    required this.shiftEndTime,
    required this.shiftBreakTime,
    required this.duration,
    required this.imageSrc,
  });

  factory FirstData.fromJson(Map<String, dynamic> json) {
    return FirstData(
      day: json['day'],
      date: json['date'],
      id: json['id'],
      shiftId: json['shift_id'],
      shiftName: json['shift_name'],
      shiftColor: json['shift_color'],
      shiftHours: json['shift_hours'],
      shiftType: json['shift_type'],
      shiftStartTime: json['shift_start_time'],
      shiftEndTime: json['shift_end_time'],
      shiftBreakTime: json['shift_break_time'],
      duration: json['duration'],
      imageSrc: json['profile_image'],
    );
  }
}
