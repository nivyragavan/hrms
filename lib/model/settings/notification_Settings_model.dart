class NotificationSettingsModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  NotificationSettingsModel({
    this.code,
    this.message,
    this.data,
  });

  NotificationSettingsModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList()
      };
}

class Data {
  final String? id;
  final String? source;
  String? email;
  String? push;
  String? sms;
  final String? type;
   String? duration;

  Data({
    this.id,
    this.source,
    this.email,
    this.push,
    this.sms,
    this.type,
    this.duration,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        source = json['source'] as String?,
        email = json['email'] as String?,
        push = json['push'] as String?,
        sms = json['sms'] as String?,
        type = json['type'] as String?,
        duration = json['duration'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'source': source,
        'email': email,
        'push': push,
        'sms': sms,
        'type': type,
        'duration': duration
      };
}
