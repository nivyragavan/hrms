class UploadNotificationSettingsModel {
   List<Notifications>? notification;
   String? branchId;

  UploadNotificationSettingsModel({
    this.notification,
    this.branchId,
  });

  UploadNotificationSettingsModel.fromJson(Map<String, dynamic> json)
      : notification = (json['notification'] as List?)?.map((dynamic e) => Notifications.fromJson(e as Map<String,dynamic>)).toList(),
        branchId = json['branch_id'] as String?;

  Map<String, dynamic> toJson() => {
    'notification' : notification?.map((e) => e.toJson()).toList(),
    'branch_id' : branchId
  };
}
class Notifications {
  final String? source;
  final String? email;
  final String? sms;
  final String? push;
  final String? status;
  final String? user_type;
  final String? duration;

  Notifications({
    this.source,
    this.email,
    this.sms,
    this.push,
    this.status,
    this.user_type,
    this.duration
  });

  Notifications.fromJson(Map<String, dynamic> json)
      : source = json['source'] as String?,
        email = json['email'] as String?,
        sms = json['sms'] as String?,
        push = json['push'] as String?,
        status = json['status'] as String?,
        user_type = json['type'] as String?,
        duration = json['duration'] as String?;

  Map<String, dynamic> toJson() => {
    'source' : source,
    'email' : email,
    'sms' : sms,
    'push' : push,
    'status' : status,
    'user_type' : user_type,
    'duration' : duration
  };
}
