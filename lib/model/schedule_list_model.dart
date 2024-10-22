class ScheduleListModel {
  final String? code;
  final String? message;
  final Dataum? data;

  ScheduleListModel({
    this.code,
    this.message,
    this.data,
  });

  ScheduleListModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Dataum.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Dataum {
  final String? currentPage;
  final List<Data>? data;
  final String? firstPageUrl;
  final String? from;
  final String? lastPage;
  final String? lastPageUrl;
  final List<Links>? links;
  final String? nextPageUrl;
  final String? path;
  final String? perPage;
  final String? prevPageUrl;
  final String? to;
  final String? total;

  Dataum({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  Dataum.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'] as String?,
        data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList(),
        firstPageUrl = json['first_page_url'] as String?,
        from = json['from'] as String?,
        lastPage = json['last_page'] as String?,
        lastPageUrl = json['last_page_url'] as String?,
        links = (json['links'] as List?)?.map((dynamic e) => Links.fromJson(e as Map<String,dynamic>)).toList(),
        nextPageUrl = json['next_page_url'] as String?,
        path = json['path'] as String?,
        perPage = json['per_page'] as String?,
        prevPageUrl = json['prev_page_url'] as String?,
        to = json['to'] as String?,
        total = json['total'] as String?;

  Map<String, dynamic> toJson() => {
    'current_page' : currentPage,
    'data' : data?.map((e) => e.toJson()).toList(),
    'first_page_url' : firstPageUrl,
    'from' : from,
    'last_page' : lastPage,
    'last_page_url' : lastPageUrl,
    'links' : links?.map((e) => e.toJson()).toList(),
    'next_page_url' : nextPageUrl,
    'path' : path,
    'per_page' : perPage,
    'prev_page_url' : prevPageUrl,
    'to' : to,
    'total' : total
  };
}

class Data {
  final String? id;
  final String? name;
  final String? email;
  final String? profileImage;
  final Department? department;
  final JobPosition? jobPosition;
  final List<ShiftList>? shiftList;

  Data({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.department,
    this.jobPosition,
    this.shiftList,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        profileImage = json['profile_image'] as String?,
        department = json['department']!=""?(json['department'] as Map<String,dynamic>?) != null ? Department.fromJson(json['department'] as Map<String,dynamic>) : null: null,
        jobPosition = json['job_position'] !=""?(json['job_position'] as Map<String,dynamic>?) != null? JobPosition.fromJson(json['job_position'] as Map<String,dynamic>) : null:null,
        shiftList = (json['shift_list'] as List?)?.map((dynamic e) => ShiftList.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'profile_image' : profileImage,
    'department' : department?.toJson(),
    'job_position' : jobPosition?.toJson(),
    'shift_list' : shiftList?.map((e) => e.toJson()).toList()
  };
}

class Department {
  final int? id;
  final String? departmentName;
  final String? description;
  final String? departmentIcon;
  final int? status;
  final String? createdAt;

  Department({
    this.id,
    this.departmentName,
    this.description,
    this.departmentIcon,
    this.status,
    this.createdAt,
  });

  Department.fromJson(Map<String, dynamic> json)
      : id = json['id'] ,
        departmentName = json['department_name'] as String?,
        description = json['description'] as String?,
        departmentIcon = json['department_icon'] as String?,
        status = json['status'] ,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'department_name' : departmentName,
    'description' : description,
    'department_icon' : departmentIcon,
    'status' : status,
    'created_at' : createdAt
  };
}

class JobPosition {
  final String? id;
  final String? userId;
  final String? positionId;
  final String? createdAt;
  final Company? company;
  final String? lineManager;
  final Position? position;

  JobPosition({
    this.id,
    this.userId,
    this.positionId,
    this.createdAt,
    this.company,
    this.lineManager,
    this.position,
  });

  JobPosition.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        userId = json['user_id'] as String?,
        positionId = json['position_id'] as String?,
        createdAt = json['created_at'] as String?,
        company = (json['company'] as Map<String,dynamic>?) != null ? Company.fromJson(json['company'] as Map<String,dynamic>) : null,
        lineManager = json['line_manager'] as String?,
        position = (json['position'] as Map<String,dynamic>?) != null ? Position.fromJson(json['position'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'user_id' : userId,
    'position_id' : positionId,
    'created_at' : createdAt,
    'company' : company?.toJson(),
    'line_manager' : lineManager,
    'position' : position?.toJson()
  };
}

class Company {
  final String? id;
  final String? domain;
  final String? tenantId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? jobTitle;
  final String? phoneNumber;
  final String? address;
  final String? employeeCount;
  final String? countryId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? createdBy;
  final String? updatedBy;
  final String? deletedBy;

  Company({
    this.id,
    this.domain,
    this.tenantId,
    this.firstName,
    this.lastName,
    this.email,
    this.jobTitle,
    this.phoneNumber,
    this.address,
    this.employeeCount,
    this.countryId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  Company.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        domain = json['domain'] as String?,
        tenantId = json['tenant_id'] as String?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        email = json['email'] as String?,
        jobTitle = json['job_title'] as String?,
        phoneNumber = json['phone_number'] as String?,
        address = json['address'] as String?,
        employeeCount = json['employee_count'] as String?,
        countryId = json['country_id'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        deletedAt = json['deleted_at'] as String?,
        createdBy = json['created_by'] as String?,
        updatedBy = json['updated_by'] as String?,
        deletedBy = json['deleted_by'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'domain' : domain,
    'tenant_id' : tenantId,
    'first_name' : firstName,
    'last_name' : lastName,
    'email' : email,
    'job_title' : jobTitle,
    'phone_number' : phoneNumber,
    'address' : address,
    'employee_count' : employeeCount,
    'country_id' : countryId,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'deleted_by' : deletedBy
  };
}

class Position {
  final String? id;
  final String? departmentId;
  final String? positionName;
  final String? grade;
  final String? createdAt;

  Position({
    this.id,
    this.departmentId,
    this.positionName,
    this.grade,
    this.createdAt,
  });

  Position.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        departmentId = json['department_id'] as String?,
        positionName = json['position_name'] as String?,
        grade = json['grade'] as String?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'department_id' : departmentId,
    'position_name' : positionName,
    'grade' : grade,
    'created_at' : createdAt
  };
}

class ShiftList {
  final String? day;
  final String? date;
  final String? id;
  final String? shiftId;
  final String? shiftName;
  final String? shiftColor;
  final String? shiftHours;
  final String? shiftType;
  final String? shiftStartTime;
  final String? shiftEndTime;
  final String? shiftBreakTime;
  final String? duration;

  ShiftList({
    this.day,
    this.date,
    this.id,
    this.shiftId,
    this.shiftName,
    this.shiftColor,
    this.shiftHours,
    this.shiftType,
    this.shiftStartTime,
    this.shiftEndTime,
    this.shiftBreakTime,
    this.duration,
  });

  ShiftList.fromJson(Map<String, dynamic> json)
      : day = json['day'] == "" ? "" : json['day'] as String?,
        date =  json['date'] == "" ? "" : json['date'] as String?,
        id = json['id'] == "" ? "" : json['id'] as String?,
        shiftId = json['shift_id'] == "" ? "" : json['shift_id'] as String?,
        shiftName = json['shift_name'] == "" ? "" : json['shift_name'] as String?,
        shiftColor = json['shift_color'] == "" ? "" :json['shift_color'] as String?,
        shiftHours = json['shift_hours']  == "" ? "" :json['shift_hours'] as String?,
        shiftType = json['shift_type'] == "" ? "" : json['shift_type'] as String?,
        shiftStartTime = json['shift_start_time']  == "" ? "" :json['shift_start_time'] as String?,
        shiftEndTime = json['shift_end_time'] == ""? "" :  json['shift_end_time'] as String?,
        shiftBreakTime = json ['shift_break_time'] == "" ? "" : json['shift_break_time'] as String?,
        duration = json ['duration'] == "" ? "" : json['duration'] as String?;

  Map<String, dynamic> toJson() => {
    'day' : day,
    'date' : date,
    'id' : id,
    'shift_id' : shiftId,
    'shift_name' : shiftName,
    'shift_color' : shiftColor,
    'shift_hours' : shiftHours,
    'shift_type' : shiftType,
    'shift_start_time' : shiftStartTime,
    'shift_end_time' : shiftEndTime,
    'shift_break_time' : shiftBreakTime,
    'duration' : duration
  };
}

class Links {
  final String? url;
  final String? label;
  final bool? active;

  Links({
    this.url,
    this.label,
    this.active,
  });

  Links.fromJson(Map<String, dynamic> json)
      : url = json['url'] as String?,
        label = json['label'] as String?,
        active = json['active'] as bool?;

  Map<String, dynamic> toJson() => {
    'url' : url,
    'label' : label,
    'active' : active
  };
}