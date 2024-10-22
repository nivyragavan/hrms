class EmployeeMasterModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  EmployeeMasterModel({
    this.code,
    this.message,
    this.data,
  });

  EmployeeMasterModel.fromJson(Map<String, dynamic> json)
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
  final List<String>? maritalStatus;
  final List<String>? gender;
  final List<String>? relationship;
  final List<String>? bloodGroup;
  final List<EmploymentType>? employmentType;

  Data({
    this.maritalStatus,
    this.gender,
    this.relationship,
    this.bloodGroup,
    this.employmentType,
  });

  Data.fromJson(Map<String, dynamic> json)
      : maritalStatus = (json['marital_status'] as List?)?.map((dynamic e) => e as String).toList(),
        gender = (json['gender'] as List?)?.map((dynamic e) => e as String).toList(),
        relationship = (json['relationship'] as List?)?.map((dynamic e) => e as String).toList(),
        bloodGroup = (json['blood_group'] as List?)?.map((dynamic e) => e as String).toList(),
        employmentType = (json['employment_type'] as List?)?.map((dynamic e) => EmploymentType.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'marital_status' : maritalStatus,
    'gender' : gender,
    'relationship' : relationship,
    'blood_group' : bloodGroup,
    'employment_type' : employmentType?.map((e) => e.toJson()).toList()
  };
}

class EmploymentType {
  final String? id;
  final String? type;

  EmploymentType({
    this.id,
    this.type,
  });

  EmploymentType.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'type' : type
  };
}