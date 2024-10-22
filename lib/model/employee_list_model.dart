// To parse this JSON data, do
//
//     final employeeListModel = employeeListModelFromJson(jsonString);

import 'dart:convert';

class EmployeeModel {
  List<Employe> empData;

  EmployeeModel({required this.empData});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    var empList = json['employee'] as List<dynamic>;
    List<Employe> employee = empList.map((e) => Employe.fromJson(e)).toList();

    return EmployeeModel(empData: employee);
  }

  Map<String, dynamic> toJson() {
    return {
      'employee': empData.map((contact) => contact.toJson()).toList(),
    };
  }
}

EmployeeListModel employeeListModelFromJson(String str) =>
    EmployeeListModel.fromJson(json.decode(str));

String employeeListModelToJson(EmployeeListModel data) =>
    json.encode(data.toJson());

class EmployeeListModel {
  final String? code;
  final String? message;
  EmployeeListModelData? data;

  EmployeeListModel({
    this.code,
    this.message,
    this.data,
  });

  factory EmployeeListModel.fromJson(Map<String, dynamic> json) => EmployeeListModel(
    code: json["code"],
    message: json["message"],
    data: EmployeeListModelData.fromJson(json["data"]),
  );

  // factory EmployeeListModel.fromJson(Map<String, dynamic> json) =>
  //     EmployeeListModel(
  //       data: EmployeeListModelData.fromJson(json["data"]),
  //     );

  Map<String, dynamic> toJson() => {
        "code":code,
        "message":message,
        "data": data?.toJson(),
      };
}

class EmployeeListModelData {
  DataData? data;

  EmployeeListModelData({
    this.data,
  });

  factory EmployeeListModelData.fromJson(Map<String, dynamic> json) =>
      EmployeeListModelData(
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
      };
}

class DataData {
  List<Datum>? data;
  String? activeCount;
  String? inactiveCount;

  DataData({
    this.data,
    this.activeCount,
    this.inactiveCount,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        activeCount: json["active_count"],
        inactiveCount: json["inactive_count"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "active_count": activeCount,
        "inactive_count": inactiveCount,
      };
}

class Datum {
  int? id;
  String? firstName;
  String? lastName;
  String? emailId;
  Gender? gender;
  MaritalStatus? maritalStatus;
  Country? country;
  DateTime? dateOfBirth;
  State? state;
  City? city;
  String? personalEmail;
  String? bloodGroup;
  String? profileImage;
  int? companyId;
  int? jobTitleId;
  int? branchId;
  int? departmentId;
  int? shiftId;
  int? reportingToId;
  int? role;
  String? mobileNumber;
  dynamic inviteRef;
  Employe? employeeType;
  int? status;
  int? datumImport;
  DateTime? createdAt;
  Company? company;
  String? userUniqueId;
  Department? department;
  // List<Department>? department;
  List<Dependent>? emergencyContactDetails;
  PersonalInfo? personalInfo;
  JobPosition? jobPosition;
  List<EducationalDetail>? educationalDetails;
  List<Dependent>? dependents;
  List<AddressDetail>? addressDetails;

  Datum({
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
    this.datumImport,
    this.createdAt,
    this.company,
    this.userUniqueId,
    this.department,
    this.emergencyContactDetails,
    this.personalInfo,
    this.jobPosition,
    this.educationalDetails,
    this.dependents,
    this.addressDetails,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        emailId: json["email_id"],
        gender: genderValues.map[json["gender"]],
        maritalStatus: maritalStatusValues.map[json["marital_status"]],
        country: json["country"] == null
            ? json["country"]
            : Country.fromJson(json["country"]),
        dateOfBirth: json["date_of_birth"] == null
            ? json["date_of_birth"]
            : DateTime.parse(json["date_of_birth"]),
        state: json["state"] == null
            ? json["state"]
            : State.fromJson(json["state"]),
        city: json["city"] == null ? json["city"] : City.fromJson(json["city"]),
        personalEmail: json["personal_email"],
        bloodGroup: json["blood_group"],
        profileImage: json["profile_image"],
        companyId: json["company_id"],
        jobTitleId: json["job_title_id"],
        branchId: json["branch_id"],
        departmentId: json["department_id"],
        shiftId: json["shift_id"],
        reportingToId: json["reporting_to_id"],
        role: json["role"],
        mobileNumber: json["mobile_number"],
        inviteRef: json["invite_ref"],
        employeeType: Employe.fromJson(json["employee_type"]),
        status: json["status"],
        datumImport: json["import"],
        createdAt: DateTime.parse(json["created_at"]),
        company: json["company"] == null
            ? json["company"]
            : Company.fromJson(json["company"]),
        userUniqueId: json["user_unique_id"],
        department: json["department"] == null
            ? null
            : Department.fromJson(json["department"]),

        // department: List<Department>.from(json["department"].map((x) => Department.fromJson(x))),
        // department: (json['department'] as List<dynamic>).map((x) => Department.fromJson(x as Map<String, dynamic>)).toList(),

        personalInfo: json["personal_info"] == null
            ? json["personal_info"]
            : PersonalInfo.fromJson(json["personal_info"]),
        jobPosition: json["job_position"] == null
            ? json["job_position"]
            : JobPosition.fromJson(json["job_position"]),
        educationalDetails: json["educational_details"] == []
            ? []
            : List<EducationalDetail>.from(json["educational_details"]
                .map((x) => EducationalDetail.fromJson(x))),
        dependents: List<Dependent>.from(
            json["dependents"].map((x) => Dependent.fromJson(x))),
        addressDetails: json["address_details"] == []
            ? []
            : List<AddressDetail>.from(
                json["address_details"].map((x) => AddressDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email_id": emailId,
        "gender": genderValues.reverse[gender],
        "marital_status": maritalStatusValues.reverse[maritalStatus],
        "country": country?.toJson(),
        "date_of_birth":
            "${dateOfBirth?.year.toString().padLeft(4, '0')}-${dateOfBirth?.month.toString().padLeft(2, '0')}-${dateOfBirth?.day.toString().padLeft(2, '0')}",
        "state": state?.toJson(),
        "city": city?.toJson(),
        "personal_email": personalEmail,
        "blood_group": bloodGroup,
        "profile_image": profileImage,
        "company_id": companyId,
        "job_title_id": jobTitleId,
        "branch_id": branchId,
        "department_id": departmentId,
        "shift_id": shiftId,
        "reporting_to_id": reportingToId,
        "role": role,
        "mobile_number": mobileNumber,
        "invite_ref": inviteRef,
        "employee_type": employeeType?.toJson(),
        "status": status,
        "import": datumImport,
        "created_at": createdAt?.toIso8601String(),
        "company": company?.toJson(),
        "user_unique_id": userUniqueId,
        "department": department?.toJson(),
        "emergency_contact_details": emergencyContactDetails != null
            ? List<dynamic>.from(
                emergencyContactDetails!.map((x) => x.toJson()))
            : null,
        "personal_info": personalInfo?.toJson(),
        "job_position": jobPosition?.toJson(),
        "educational_details":
            List<dynamic>.from(educationalDetails!.map((x) => x.toJson())),
        "dependents": List<dynamic>.from(dependents!.map((x) => x.toJson())),
        "address_details":
            List<dynamic>.from(addressDetails!.map((x) => x.toJson())),
      };
}

class AddressDetail {
  int? id;
  int? userId;
  String? primaryAddress;
  int? countryId;
  int? state;
  int? city;
  String? postalCode;
  DateTime? createdAt;

  AddressDetail({
    this.id,
    this.userId,
    this.primaryAddress,
    this.countryId,
    this.state,
    this.city,
    this.postalCode,
    this.createdAt,
  });

  factory AddressDetail.fromJson(Map<String, dynamic> json) => AddressDetail(
        id: json["id"],
        userId: json["user_id"],
        primaryAddress: json["primary_address"],
        countryId: json["country_id"],
        state: json["state"],
        city: json["city"],
        postalCode: json["postal_code"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "primary_address": primaryAddress,
        "country_id": countryId,
        "state": state,
        "city": city,
        "postal_code": postalCode,
        "created_at": createdAt?.toIso8601String(),
      };
}

class City {
  int? id;
  String? name;
  int? stateId;
  String? stateCode;
  int? countryId;
  CountryCode? countryCode;
  String? latitude;
  String? longitude;

  City({
    this.id,
    this.name,
    this.stateId,
    this.stateCode,
    this.countryId,
    this.countryCode,
    this.latitude,
    this.longitude,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"],
        name: json["name"],
        stateId: json["state_id"],
        stateCode: json["state_code"],
        countryId: json["country_id"],
        countryCode: countryCodeValues.map[json["country_code"]],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "state_code": stateCode,
        "country_id": countryId,
        "country_code": countryCodeValues.reverse[countryCode],
        "latitude": latitude,
        "longitude": longitude,
      };
}

enum CountryCode { IN, AF, AU }

final countryCodeValues = EnumValues(
    {"AF": CountryCode.AF, "AU": CountryCode.AU, "IN": CountryCode.IN});

class Company {
  int? id;
  Domain? domain;
  TenantId? tenantId;
  FirstName? firstName;
  LastName? lastName;
  Email? email;
  dynamic jobTitle;
  String? phoneNumber;
  Address? address;
  String? employeeCount;
  int? countryId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

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

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        domain: domainValues.map[json["domain"]],
        tenantId: tenantIdValues.map[json["tenant_id"]],
        firstName: firstNameValues.map[json["first_name"]],
        lastName: lastNameValues.map[json["last_name"]],
        email: emailValues.map[json["email"]],
        jobTitle: json["job_title"] == null ? "-" : json["job_title"] ?? "-",
        phoneNumber: json["phone_number"] == null
            ? json["phone_number"]
            : json["phone_number"],
        address: addressValues.map[json["address"]],
        employeeCount: json["employee_count"],
        countryId: json["country_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "domain": domainValues.reverse[domain],
        "tenant_id": tenantIdValues.reverse[tenantId],
        "first_name": firstNameValues.reverse[firstName],
        "last_name": lastNameValues.reverse[lastName],
        "email": emailValues.reverse[email],
        "job_title": jobTitle,
        "phone_number": phoneNumber,
        "address": addressValues.reverse[address],
        "employee_count": employeeCount,
        "country_id": countryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
      };
}

enum Address { TEST }

final addressValues = EnumValues({"test": Address.TEST});

enum Domain { TENANT1 }

final domainValues = EnumValues({"tenant1.": Domain.TENANT1});

enum Email { SARANYA_DREAMGUYS_COM, DREAMSADMIN_GMAIL_COM }

final emailValues = EnumValues({
  "dreamsadmin@gmail.com": Email.DREAMSADMIN_GMAIL_COM,
  "saranya@dreamguys.com": Email.SARANYA_DREAMGUYS_COM
});

enum FirstName { EMPTY, DREAMS }

final firstNameValues =
    EnumValues({"dreams": FirstName.DREAMS, "": FirstName.EMPTY});

enum LastName { EMPTY, ADMIN }

final lastNameValues =
    EnumValues({"admin": LastName.ADMIN, "": LastName.EMPTY});

enum TenantId { TENANT1 }

final tenantIdValues = EnumValues({"tenant1": TenantId.TENANT1});

class Country {
  int? id;
  String? name;
  Iso3? iso3;
  CountryCode? iso2;
  String? phoneCode;
  Capital? capital;
  Currency? currency;
  Native? native;
  Emoji? emoji;
  EmojiU? emojiU;
  DateTime? createdAt;

  Country({
    this.id,
    this.name,
    this.iso3,
    this.iso2,
    this.phoneCode,
    this.capital,
    this.currency,
    this.native,
    this.emoji,
    this.emojiU,
    this.createdAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
        iso3: iso3Values.map[json["iso3"]],
        iso2: countryCodeValues.map[json["iso2"]],
        phoneCode: json["phone_code"],
        capital: capitalValues.map[json["capital"]],
        currency: currencyValues.map[json["currency"]],
        native: nativeValues.map[json["native"]],
        emoji: emojiValues.map[json["emoji"]],
        emojiU: emojiUValues.map[json["emojiU"]],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "iso3": iso3Values.reverse[iso3],
        "iso2": countryCodeValues.reverse[iso2],
        "phone_code": phoneCode,
        "capital": capitalValues.reverse[capital],
        "currency": currencyValues.reverse[currency],
        "native": nativeValues.reverse[native],
        "emoji": emojiValues.reverse[emoji],
        "emojiU": emojiUValues.reverse[emojiU],
        "created_at": createdAt?.toIso8601String(),
      };
}

enum Capital { NEW_DELHI, KABUL, CANBERRA }

final capitalValues = EnumValues({
  "Canberra": Capital.CANBERRA,
  "Kabul": Capital.KABUL,
  "New Delhi": Capital.NEW_DELHI
});

enum Currency { INR, AFN, AUD }

final currencyValues =
    EnumValues({"AFN": Currency.AFN, "AUD": Currency.AUD, "INR": Currency.INR});

enum Emoji { EMPTY, EMOJI, PURPLE }

final emojiValues = EnumValues({
  "\ud83c\udde6\ud83c\uddeb": Emoji.EMOJI,
  "\ud83c\uddee\ud83c\uddf3": Emoji.EMPTY,
  "\ud83c\udde6\ud83c\uddfa": Emoji.PURPLE
});

enum EmojiU { U_1_F1_EE_U_1_F1_F3, U_1_F1_E6_U_1_F1_EB, U_1_F1_E6_U_1_F1_FA }

final emojiUValues = EnumValues({
  "U+1F1E6 U+1F1EB": EmojiU.U_1_F1_E6_U_1_F1_EB,
  "U+1F1E6 U+1F1FA": EmojiU.U_1_F1_E6_U_1_F1_FA,
  "U+1F1EE U+1F1F3": EmojiU.U_1_F1_EE_U_1_F1_F3
});

enum Iso3 { IND, AFG, AUS }

final iso3Values =
    EnumValues({"AFG": Iso3.AFG, "AUS": Iso3.AUS, "IND": Iso3.IND});

enum Name { INDIA, AFGHANISTAN, AUSTRALIA }

final nameValues = EnumValues({
  "Afghanistan": Name.AFGHANISTAN,
  "Australia": Name.AUSTRALIA,
  "India": Name.INDIA
});

enum Native { EMPTY, NATIVE, AUSTRALIA }

final nativeValues = EnumValues({
  "Australia": Native.AUSTRALIA,
  "भारत": Native.EMPTY,
  "افغانستان": Native.NATIVE
});

class Department {
  int? id;
  String? departmentName;
  String? description;
  String? departmentIcon;
  int? status;
  DateTime? createdAt;

  Department({
    this.id,
    this.departmentName,
    this.description,
    this.departmentIcon,
    this.status,
    this.createdAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        departmentName:json["department_name" ],
        description: json["description"],
        departmentIcon: json["department_icon"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentNameValues.reverse[departmentName],
        "description": departmentNameValues.reverse[description],
        "department_icon": departmentIcon,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
      };
}

enum DepartmentName { HR, DEVELOPER }

final departmentNameValues = EnumValues(
    {"Developer": DepartmentName.DEVELOPER, "HR": DepartmentName.HR});

class Dependent {
  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  Gender? gender;
  Relationship? relationship;
  String? phoneNumber;
  String? emailAddress;
  DateTime? createdAt;

  Dependent({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.gender,
    this.relationship,
    this.phoneNumber,
    this.emailAddress,
    this.createdAt,
  });

  factory Dependent.fromJson(Map<String, dynamic> json) => Dependent(
        id: json["id"],
        userId: json["user_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: genderValues.map[json["gender"]],
        relationship: relationshipValues.map[json["relationship"]],
        phoneNumber: json["phone_number"],
        emailAddress: json["email_address"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "first_name": firstName,
        "last_name": lastName,
        "gender": genderValues.reverse[gender],
        "relationship": relationshipValues.reverse[relationship],
        "phone_number": phoneNumber,
        "email_address": emailAddress,
        "created_at": createdAt?.toIso8601String(),
      };
}

enum Gender { MALE, FEMALE, GENDER_MALE, GENDER_FEMALE }

final genderValues = EnumValues({
  "Female": Gender.FEMALE,
  "female": Gender.GENDER_FEMALE,
  "male": Gender.GENDER_MALE,
  "Male": Gender.MALE
});

enum Relationship {
  FATHER,
  SPOUSE,
  BROTHER,
  MOTHER,
  SISTER,
  DAUGHTER,
  SON,
  BRO
}

final relationshipValues = EnumValues({
  "bro": Relationship.BRO,
  "Brother": Relationship.BROTHER,
  "daughter": Relationship.DAUGHTER,
  "Father": Relationship.FATHER,
  "Mother": Relationship.MOTHER,
  "Sister": Relationship.SISTER,
  "son": Relationship.SON,
  "Spouse": Relationship.SPOUSE
});

class EducationalDetail {
  int? id;
  int? userId;
  String? degree;
  String? specialization;
  String? collegeName;
  String? gpa;
  DateTime? startYear;
  DateTime? endYear;
  DateTime? createdAt;

  EducationalDetail({
    this.id,
    this.userId,
    this.degree,
    this.specialization,
    this.collegeName,
    this.gpa,
    this.startYear,
    this.endYear,
    this.createdAt,
  });

  factory EducationalDetail.fromJson(Map<String, dynamic> json) =>
      EducationalDetail(
        id: json["id"],
        userId: json["user_id"],
        degree: json["degree"],
        specialization: json["specialization"],
        collegeName: json["college_name"],
        gpa: json["gpa"],
        startYear: DateTime.parse(json["start_year"]),
        endYear: DateTime.parse(json["end_year"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "degree": degree,
        "specialization": specialization,
        "college_name": collegeName,
        "gpa": gpa,
        "start_year":
            "${startYear?.year.toString().padLeft(4, '0')}-${startYear?.month.toString().padLeft(2, '0')}-${startYear?.day.toString().padLeft(2, '0')}",
        "end_year":
            "${endYear?.year.toString().padLeft(4, '0')}-${endYear?.month.toString().padLeft(2, '0')}-${endYear?.day.toString().padLeft(2, '0')}",
        "created_at": createdAt?.toIso8601String(),
      };
}

class Employe {
  String? id;
  Type? type;

  Employe({
    this.id,
    this.type,
  });

  factory Employe.fromJson(Map<String, dynamic> json) => Employe(
        id: json["id"],
        type: typeValues.map[json["type"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": typeValues.reverse[type],
      };
}

enum Type { CONTRACT, FULL_TIME, PERMANANT, PART_TIME }

final typeValues = EnumValues({
  "Contract": Type.CONTRACT,
  "Full Time": Type.FULL_TIME,
  "Part Time": Type.PART_TIME,
  "Permanant": Type.PERMANANT
});

class JobPosition {
  int? id;
  int? userId;
  int? positionId;
  DateTime? createdAt;
  Company? company;
  String? lineManager;
  Position? position;

  JobPosition({
    this.id,
    this.userId,
    this.positionId,
    this.createdAt,
    this.company,
    this.lineManager,
    this.position,
  });

  factory JobPosition.fromJson(Map<String, dynamic> json) => JobPosition(
        id: json["id"],
        userId: json["user_id"],
        positionId: json["position_id"],
        createdAt: DateTime.parse(json["created_at"]),
        company: json["company"] == null
            ? json["company"]
            : Company.fromJson(json["company"]),
        lineManager: json["line_manager"],
        position: Position.fromJson(json["position"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "position_id": positionId,
        "created_at": createdAt?.toIso8601String(),
        "company": company?.toJson(),
        "line_manager": lineManager,
        "position": position?.toJson(),
      };
}

class Position {
  int? id;
  int? departmentId;
  String? positionName;
  Grade? grade;
  DateTime? createdAt;

  Position({
    this.id,
    this.departmentId,
    this.positionName,
    this.grade,
    this.createdAt,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        id: json["id"],
        departmentId: json["department_id"],
        positionName: json[
            "position_name"], // positionNameValues.map[json["position_name"]],
        grade: Grade.fromJson(json["grade"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_id": departmentId,
        "position_name": positionNameValues.reverse[positionName],
        "grade": grade?.toJson(),
        "created_at": createdAt?.toIso8601String(),
      };
}

class Grade {
  int? id;
  GradeName? gradeName;

  Grade({
    this.id,
    this.gradeName,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        id: json["id"],
        gradeName: gradeNameValues.map[json["grade_name"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "grade_name": gradeNameValues.reverse[gradeName],
      };
}

enum GradeName { A }

final gradeNameValues = EnumValues({"A": GradeName.A});

enum PositionName {
  HR_ACCOUNTANT,
  SENIOR_DEVELOPER,
  DELEOPER_MANAGER,
  HR_MANAGER
}

final positionNameValues = EnumValues({
  "Deleoper Manager": PositionName.DELEOPER_MANAGER,
  "HR Accountant": PositionName.HR_ACCOUNTANT,
  "HR Manager": PositionName.HR_MANAGER,
  "Senior developer": PositionName.SENIOR_DEVELOPER
});

enum MaritalStatus {
  MARRIED,
  SINGLE,
  MARITAL_STATUS_SINGLE,
  MARITAL_STATUS_MARRIED
}

final maritalStatusValues = EnumValues({
  "married": MaritalStatus.MARITAL_STATUS_MARRIED,
  "single": MaritalStatus.MARITAL_STATUS_SINGLE,
  "Married": MaritalStatus.MARRIED,
  "Single": MaritalStatus.SINGLE
});

class PersonalInfo {
  int? id;
  int? userId;
  String? branchId;
  String? employeeId;
  DateTime? effectiveDate;
  int? employementType;
  int? shiftId;
  String? shiftTime;
  int? status;
  int? probationPeriod;
  dynamic probationStartDate;
  dynamic probationEndDate;
  dynamic createdAt;
  Employe? employementTypeData;

  PersonalInfo({
    this.id,
    this.userId,
    this.branchId,
    this.employeeId,
    this.effectiveDate,
    this.employementType,
    this.shiftId,
    this.shiftTime,
    this.status,
    this.probationPeriod,
    this.probationStartDate,
    this.probationEndDate,
    this.createdAt,
    this.employementTypeData,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
        id: json["id"],
        userId: json["user_id"],
        branchId: json["branch_id"],
        employeeId: json["employee_id"],
        effectiveDate: DateTime.parse(json["effective_date"]),
        employementType: json["employement_type"],
        shiftId: json["shift_id"],
        shiftTime: json["shift_time"],
        status: json["status"],
        probationPeriod: json["probation_period"],
        probationStartDate: json["probation_start_date"] ?? "",
        probationEndDate: json["probation_end_date"] ?? "",
        createdAt: json["created_at"],
        employementTypeData: Employe.fromJson(json["employement_type_data"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "branch_id": branchId,
        "employee_id": employeeId,
        "effective_date":
            "${effectiveDate?.year.toString().padLeft(4, '0')}-${effectiveDate?.month.toString().padLeft(2, '0')}-${effectiveDate?.day.toString().padLeft(2, '0')}",
        "employement_type": employementType,
        "shift_id": shiftId,
        "shift_time": shiftTime,
        "status": status,
        "probation_period": probationPeriod,
        "probation_start_date": probationStartDate,
        // "${probationStartDate?.year.toString().padLeft(4, '0')}-${probationStartDate?.month.toString().padLeft(2, '0')}-${probationStartDate?.day.toString().padLeft(2, '0')}",
        "probation_end_date": probationEndDate,
        // "${probationEndDate?.year.toString().padLeft(4, '0')}-${probationEndDate?.month.toString().padLeft(2, '0')}-${probationEndDate?.day.toString().padLeft(2, '0')}",
        "created_at": createdAt, //createdAt?.toIso8601String(),
        "employement_type_data": employementTypeData?.toJson(),
      };
}

class State {
  int? id;
  String? name;
  int? countryId;
  CountryCode? countryCode;
  String? stateCode;

  State({
    this.id,
    this.name,
    this.countryId,
    this.countryCode,
    this.stateCode,
  });

  factory State.fromJson(Map<String, dynamic> json) => State(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        countryCode: countryCodeValues.map[json["country_code"]],
        stateCode: json["state_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "country_code": countryCodeValues.reverse[countryCode],
        "state_code": stateCode,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
