class ShiftListModel {
  final String? code;
  final String? message;
  final Data? data;

  ShiftListModel({
    this.code,
    this.message,
    this.data,
  });

  ShiftListModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String, dynamic>?) != null
            ? Data.fromJson(json['data'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {'code': code, 'message': message, 'data': data?.toJson()};
}

class Data {
  final String? shiftCount;
  final List<ListArray>? list;

  Data({
    this.shiftCount,
    this.list,
  });

  Data.fromJson(Map<String, dynamic> json)
      : shiftCount = json['shift_count'] as String?,
        list = (json['list'] as List?)
            ?.map((dynamic e) => ListArray.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'shift_count': shiftCount,
        'list': list?.map((e) => e.toJson()).toList()
      };
}

class ListArray {
  final String? id;
  final String? shiftName;
  final String? color;
  final String? maxHours;
  final List<WorkTime>? workTime;
  final String? shiftType;

  ListArray({
    this.id,
    this.shiftName,
    this.color,
    this.maxHours,
    this.workTime,
    this.shiftType,
  });

  ListArray.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        shiftName = json['shift_name'] as String?,
        color = json['color'] as String?,
        maxHours = json['max_hours'] as String?,
        workTime = (json['work_time'] as List?)
            ?.map((dynamic e) => WorkTime.fromJson(e as Map<String, dynamic>))
            .toList(),
        shiftType = json['shift_type'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'shift_name': shiftName,
        'color': color,
        'max_hours': maxHours,
        'work_time': workTime?.map((e) => e.toJson()).toList(),
        'shift_type': shiftType
      };
}

class WorkTime {
  final int? id;
  final int? shiftId;
  final String? days;
  final String? startTime;
  final String? endTime;
  final String? breakTime;
  final dynamic duration;
  final String? createdAt;
  final int? createdBy;

  WorkTime({
    this.id,
    this.shiftId,
    this.days,
    this.startTime,
    this.endTime,
    this.breakTime,
    this.duration,
    this.createdAt,
    this.createdBy,
  });

  WorkTime.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        shiftId = json['shift_id'] as int?,
        days = json['days'] as String?,
        startTime = json['start_time'] as String?,
        endTime = json['end_time'] as String?,
        breakTime = json['break_time'] as String?,
        duration = json['duration'],
        createdAt = json['created_at'] as String?,
        createdBy = json['created_by'] as int?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'shift_id': shiftId,
        'days': days,
        'start_time': startTime,
        'end_time': endTime,
        'break_time': breakTime,
        'duration': duration,
        'created_at': createdAt,
        'created_by': createdBy
      };
}
