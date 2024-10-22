class LineManagerModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  LineManagerModel({
    this.code,
    this.message,
    this.data,
  });

  LineManagerModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final String? emailId;
  final String? firstName;
  final String? lastName;

  Data({
    this.id,
    this.emailId,
    this.firstName,
    this.lastName,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        emailId = json['email_id'] as String?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'email_id' : emailId,
    'first_name' : firstName,
    'last_name' : lastName
  };
}