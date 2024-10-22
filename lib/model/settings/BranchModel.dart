class BranchListModel {
  final String? code;
  final String? message;
  final List<Data>? data;

  BranchListModel({
    this.code,
    this.message,
    this.data,
  });

  BranchListModel.fromJson(Map<String, dynamic> json)
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
  final String? officeName;
  final String? officeFulladdress;
  final String? officeImage;
  final int? geofencingStatus;
  final String? officeAddress;
  final ClockLimitRadius? clockLimitRadius;
  final int? allowArea;
  final int? setHq;
  final String? createdAt;
  final dynamic deletedAt;
  final int? branchUserCount;

  Data({
    this.id,
    this.officeName,
    this.officeFulladdress,
    this.officeImage,
    this.geofencingStatus,
    this.officeAddress,
    this.clockLimitRadius,
    this.allowArea,
    this.setHq,
    this.createdAt,
    this.deletedAt,
    this.branchUserCount,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        officeName = json['office_name'] as String?,
        officeFulladdress = json['office_fulladdress'] as String?,
        officeImage = json['office_image'] as String?,
        geofencingStatus = json['geofencing_status'] as int?,
        officeAddress = json['office_address'] as String?,
        clockLimitRadius = (json['clock_limit_radius'] as Map<String,dynamic>?) != null ? ClockLimitRadius.fromJson(json['clock_limit_radius'] as Map<String,dynamic>) : null,
        allowArea = json['allow_area'] as int?,
        setHq = json['set_hq'] as int?,
        createdAt = json['created_at'] as String?,
        deletedAt = json['deleted_at'],
        branchUserCount = json['branch_user_count'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'office_name' : officeName,
    'office_fulladdress' : officeFulladdress,
    'office_image' : officeImage,
    'geofencing_status' : geofencingStatus,
    'office_address' : officeAddress,
    'clock_limit_radius' : clockLimitRadius?.toJson(),
    'allow_area' : allowArea,
    'set_hq' : setHq,
    'created_at' : createdAt,
    'deleted_at' : deletedAt,
    'branch_user_count' : branchUserCount
  };
}

class ClockLimitRadius {
  final String? id;
  final String? distance;

  ClockLimitRadius({
    this.id,
    this.distance,
  });

  ClockLimitRadius.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        distance = json['distance'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'distance' : distance
  };
}