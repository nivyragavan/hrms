class EmployeeAnnouncementViewModel {
  final String? code;
  final String? message;
  final EmpAnnouncementData? data;

  EmployeeAnnouncementViewModel({
    this.code,
    this.message,
    this.data,
  });

  EmployeeAnnouncementViewModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? EmpAnnouncementData.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.toJson()
  };
}

class EmpAnnouncementData {
  final Data? data;

  EmpAnnouncementData({
    this.data,
  });

  EmpAnnouncementData.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'data' : data?.toJson()
  };
}

class Data {
  final int? id;
  final int? userId;
  final int? announcementId;
  final dynamic departmentId;
  final dynamic positionId;
  final int? seen;
  final String? createdAt;
  final Announcement? announcement;
  final dynamic createdUser;
  final User? user;

  Data({
    this.id,
    this.userId,
    this.announcementId,
    this.departmentId,
    this.positionId,
    this.seen,
    this.createdAt,
    this.announcement,
    this.createdUser,
    this.user,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        announcementId = json['announcement_id'] as int?,
        departmentId = json['department_id'],
        positionId = json['position_id'],
        seen = json['seen'] as int?,
        createdAt = json['created_at'] as String?,
        announcement = (json['announcement'] as Map<String,dynamic>?) != null ? Announcement.fromJson(json['announcement'] as Map<String,dynamic>) : null,
        createdUser = json['created_user'],
        user = (json['user'] as Map<String,dynamic>?) != null ? User.fromJson(json['user'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'user_id' : userId,
    'announcement_id' : announcementId,
    'department_id' : departmentId,
    'position_id' : positionId,
    'seen' : seen,
    'created_at' : createdAt,
    'announcement' : announcement?.toJson(),
    'created_user' : createdUser,
    'user' : user?.toJson()
  };
}

class Announcement {
  final int? id;
  final String? subject;
  final String? message;
  final String? attachment;
  final int? publish;
  final String? createdAt;
  final List<ViewedData>? viewedData;

  Announcement({
    this.id,
    this.subject,
    this.message,
    this.attachment,
    this.publish,
    this.createdAt,
    this.viewedData,
  });

  Announcement.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        subject = json['subject'] as String?,
        message = json['message'] as String?,
        attachment = json['attachment'] as String?,
        publish = json['publish'] as int?,
        createdAt = json['created_at'] as String?,
        viewedData = (json['viewed_data'] as List?)?.map((dynamic e) => ViewedData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'id' : id,
    'subject' : subject,
    'message' : message,
    'attachment' : attachment,
    'publish' : publish,
    'created_at' : createdAt,
    'viewed_data' : viewedData?.map((e) => e.toJson()).toList()
  };
}

class ViewedData {
  final int? id;
  final int? userId;
  final int? announcementId;
  final dynamic departmentId;
  final dynamic positionId;
  final int? seen;
  final String? createdAt;

  ViewedData({
    this.id,
    this.userId,
    this.announcementId,
    this.departmentId,
    this.positionId,
    this.seen,
    this.createdAt,
  });

  ViewedData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        announcementId = json['announcement_id'] as int?,
        departmentId = json['department_id'],
        positionId = json['position_id'],
        seen = json['seen'] as int?,
        createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'user_id' : userId,
    'announcement_id' : announcementId,
    'department_id' : departmentId,
    'position_id' : positionId,
    'seen' : seen,
    'created_at' : createdAt
  };
}

class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? emailId;
  final String? gender;
  final String? maritalStatus;
  final int? country;
  final String? dateOfBirth;
  final int? state;
  final int? city;
  final String? personalEmail;
  final String? bloodGroup;
  final String? profileImage;
  final int? companyId;
  final int? jobTitleId;
  final int? branchId;
  final int? departmentId;
  final int? shiftId;
  final int? reportingToId;
  final int? role;
  final String? mobileNumber;
  final dynamic inviteRef;
  final int? employeeType;
  final int? status;
  final int? import;
  final String? createdAt;
  final dynamic deviceToken;
  final dynamic fcmToken;
  final dynamic punchInImage;
  final int? punchInStatus;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.emailId,
    this.gender,
    this.maritalStatus,
    this.country,
    this.dateOfBirth,
    this.state,
    this.city,
    this.personalEmail,
    this.bloodGroup,
    this.profileImage,
    this.companyId,
    this.jobTitleId,
    this.branchId,
    this.departmentId,
    this.shiftId,
    this.reportingToId,
    this.role,
    this.mobileNumber,
    this.inviteRef,
    this.employeeType,
    this.status,
    this.import,
    this.createdAt,
    this.deviceToken,
    this.fcmToken,
    this.punchInImage,
    this.punchInStatus,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?,
        emailId = json['email_id'] as String?,
        gender = json['gender'] as String?,
        maritalStatus = json['marital_status'] as String?,
        country = json['country'] as int?,
        dateOfBirth = json['date_of_birth'] as String?,
        state = json['state'] as int?,
        city = json['city'] as int?,
        personalEmail = json['personal_email'] as String?,
        bloodGroup = json['blood_group'] as String?,
        profileImage = json['profile_image'] as String?,
        companyId = json['company_id'] as int?,
        jobTitleId = json['job_title_id'] as int?,
        branchId = json['branch_id'] as int?,
        departmentId = json['department_id'] as int?,
        shiftId = json['shift_id'] as int?,
        reportingToId = json['reporting_to_id'] as int?,
        role = json['role'] as int?,
        mobileNumber = json['mobile_number'] as String?,
        inviteRef = json['invite_ref'],
        employeeType = json['employee_type'] as int?,
        status = json['status'] as int?,
        import = json['import'] as int?,
        createdAt = json['created_at'] as String?,
        deviceToken = json['device_token'],
        fcmToken = json['fcm_token'],
        punchInImage = json['punch_in_image'],
        punchInStatus = json['punch_in_status'] as int?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'first_name' : firstName,
    'last_name' : lastName,
    'email_id' : emailId,
    'gender' : gender,
    'marital_status' : maritalStatus,
    'country' : country,
    'date_of_birth' : dateOfBirth,
    'state' : state,
    'city' : city,
    'personal_email' : personalEmail,
    'blood_group' : bloodGroup,
    'profile_image' : profileImage,
    'company_id' : companyId,
    'job_title_id' : jobTitleId,
    'branch_id' : branchId,
    'department_id' : departmentId,
    'shift_id' : shiftId,
    'reporting_to_id' : reportingToId,
    'role' : role,
    'mobile_number' : mobileNumber,
    'invite_ref' : inviteRef,
    'employee_type' : employeeType,
    'status' : status,
    'import' : import,
    'created_at' : createdAt,
    'device_token' : deviceToken,
    'fcm_token' : fcmToken,
    'punch_in_image' : punchInImage,
    'punch_in_status' : punchInStatus
  };
}