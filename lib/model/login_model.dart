// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? code;
  String? message;
  Data? data;

  LoginModel({
    this.code,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  // Headers? headers;
  DataOriginal? original;
  // dynamic? exception;

  Data({
    // this.headers,
    this.original,
    // this.exception,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        // headers: Headers.fromJson(json["headers"]),
        original: DataOriginal.fromJson(json["original"]),
        // exception: json["exception"],
      );

  Map<String, dynamic> toJson() => {
        // "headers": headers?.toJson(),
        "original": original?.toJson(),
        // "exception": exception,
      };
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => Headers();

  Map<String, dynamic> toJson() => {};
}

class DataOriginal {
  String? accessToken;
  String? tokenType;
  User? user;
  // LibsodiyumSettings? shift;
  Domain? domain;
  String? companyImage;
  LibsodiyumSettings? libsodiyumSettings;
  // List<ThemeSetting>? themeSettings;
  BranchSettings? branchSettings;
  SystemSettings? systemSettings;

  DataOriginal({
    this.accessToken,
    this.tokenType,
    this.user,
    // this.shift,
    this.domain,
    this.companyImage,
    this.libsodiyumSettings,
    // this.themeSettings,
    this.branchSettings,
    this.systemSettings,
  });

  factory DataOriginal.fromJson(Map<String, dynamic> json) => DataOriginal(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        user: User.fromJson(json["user"]),
        // shift: LibsodiyumSettings.fromJson(json["shift"]),
        domain: json["domain"] == null
            ? json["domain"]
            : Domain.fromJson(json["domain"]),
        companyImage: json["company_image"],
        libsodiyumSettings:
            LibsodiyumSettings.fromJson(json["libsodiyum_settings"]),
        // themeSettings: List<ThemeSetting>.from(json["theme_settings"].map((x) => ThemeSetting.fromJson(x))),
        branchSettings: BranchSettings.fromJson(json["branch_settings"]),
        systemSettings: SystemSettings.fromJson(json["system_settings"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "user": user?.toJson(),
        // "shift": shift?.toJson(),
        "domain": domain?.toJson(),
        "company_image": companyImage,
        "libsodiyum_settings": libsodiyumSettings?.toJson(),
        // "theme_settings": List<dynamic>.from(themeSettings!.map((x) => x.toJson())),
        "branch_settings": branchSettings?.toJson(),
        "system_settings": systemSettings?.toJson(),
      };
}

class BranchSettings {
  int? id;
  String? officeName;
  String? officeFulladdress;
  String? officeImage;
  int? geofencingStatus;
  String? officeAddress;
  ClockLimitRadius? clockLimitRadius;
  int? latitude;
  int? longitude;
  int? allowArea;
  int? setHq;
  DateTime? createdAt;
  dynamic? deletedAt;

  BranchSettings({
    this.id,
    this.officeName,
    this.officeFulladdress,
    this.officeImage,
    this.geofencingStatus,
    this.officeAddress,
    this.clockLimitRadius,
    this.latitude,
    this.longitude,
    this.allowArea,
    this.setHq,
    this.createdAt,
    this.deletedAt,
  });

  factory BranchSettings.fromJson(Map<String, dynamic> json) => BranchSettings(
        id: json["id"],
        officeName: json["office_name"],
        officeFulladdress: json["office_fulladdress"],
        officeImage: json["office_image"],
        geofencingStatus: json["geofencing_status"],
        officeAddress: json["office_address"],
        clockLimitRadius: ClockLimitRadius.fromJson(json["clock_limit_radius"]),
        latitude: json["latitude"],
        longitude: json["longitude"],
        allowArea: json["allow_area"],
        setHq: json["set_hq"],
        createdAt: DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "office_name": officeName,
        "office_fulladdress": officeFulladdress,
        "office_image": officeImage,
        "geofencing_status": geofencingStatus,
        "office_address": officeAddress,
        "clock_limit_radius": clockLimitRadius?.toJson(),
        "latitude": latitude,
        "longitude": longitude,
        "allow_area": allowArea,
        "set_hq": setHq,
        "created_at": createdAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

class ClockLimitRadius {
  String? id;
  String? distance;

  ClockLimitRadius({
    this.id,
    this.distance,
  });

  factory ClockLimitRadius.fromJson(Map<String, dynamic> json) =>
      ClockLimitRadius(
        id: json["id"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "distance": distance,
      };
}

class Domain {
  int? id;
  String? domain;
  String? tenantId;
  String? firstName;
  String? lastName;
  String? email;
  dynamic? jobTitle;
  dynamic? phoneNumber;
  dynamic? address;
  dynamic? employeeCount;
  int? countryId;
  dynamic? createdAt;
  dynamic? updatedAt;
  dynamic? deletedAt;
  dynamic? createdBy;
  dynamic? updatedBy;
  dynamic? deletedBy;

  Domain({
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

  factory Domain.fromJson(Map<String, dynamic> json) => Domain(
        id: json["id"],
        domain: json["domain"],
        tenantId: json["tenant_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        jobTitle: json["job_title"],
        phoneNumber: json["phone_number"],
        address: json["address"],
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
        "domain": domain,
        "tenant_id": tenantId,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "job_title": jobTitle,
        "phone_number": phoneNumber,
        "address": address,
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

class LibsodiyumSettings {
  Headers? headers;
  LibsodiyumSettingsOriginal? original;
  dynamic? exception;

  LibsodiyumSettings({
    this.headers,
    this.original,
    this.exception,
  });

  factory LibsodiyumSettings.fromJson(Map<String, dynamic> json) =>
      LibsodiyumSettings(
        headers: Headers.fromJson(json["headers"]),
        original: LibsodiyumSettingsOriginal.fromJson(json["original"]),
        exception: json["exception"],
      );

  Map<String, dynamic> toJson() => {
        "headers": headers?.toJson(),
        "original": original?.toJson(),
        "exception": exception,
      };
}

class LibsodiyumSettingsOriginal {
  String? code;
  String? message;
  List<Datum>? data;

  LibsodiyumSettingsOriginal({
    this.code,
    this.message,
    this.data,
  });

  factory LibsodiyumSettingsOriginal.fromJson(Map<String, dynamic> json) =>
      LibsodiyumSettingsOriginal(
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  int? requestEnc;
  int? responseEnc;
  dynamic createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.requestEnc,
    this.responseEnc,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        requestEnc: json["request_enc"],
        responseEnc: json["response_enc"],
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "request_enc": requestEnc,
        "response_enc": responseEnc,
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class SystemSettings {
  int? id;
  int? branchId;
  int? timezoneId;
  TimezoneEFormat? timezoneDateFormat;
  String? firstDayOfWeek;
  TimezoneEFormat? timezoneTimeFormat;
  int? language;
  // Currency? currency;
  int? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic? deletedAt;
  final Languages? languages;

  SystemSettings({this.id,
    this.branchId,
    this.timezoneId,
    this.timezoneDateFormat,
    this.firstDayOfWeek,
    this.timezoneTimeFormat,
    this.language,
    // this.currency,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.languages
  });

  factory SystemSettings.fromJson(Map<String, dynamic> json) => SystemSettings(
        id: json["id"],
        branchId: json["branch_id"],
        timezoneId: json["timezone_id"],
        timezoneDateFormat:
            TimezoneEFormat.fromJson(json["timezone_date_format"]),
        firstDayOfWeek: json["first_day_of_week"],
        timezoneTimeFormat:
            TimezoneEFormat.fromJson(json["timezone_time_format"]),
        language: json["language"],
   // currency: Currency.fromJson(json['currency'] as Map<String,dynamic>),
   //  createdBy = json['created_by'] as int?,
        createdBy: json["created_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        languages: json["languages"] == null
            ? json["languages"]
            : Languages.fromJson(json["languages"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_id": branchId,
        "timezone_id": timezoneId,
        "timezone_date_format": timezoneDateFormat?.toJson(),
        "first_day_of_week": firstDayOfWeek,
        "timezone_time_format": timezoneTimeFormat?.toJson(),
        "language": language,
    // 'currency' : currency?.toJson(),
        "created_by": createdBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        // 'languages': languages?.toJson()
      };
}
class Currency {
  final int? id;
  final String? code;
  final String? name;
  final String? symbol;
  final dynamic description;
  final int? status;
  final dynamic orgId;
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  Currency({
    this.id,
    this.code,
    this.name,
    this.symbol,
    this.description,
    this.status,
    this.orgId,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Currency.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        code = json['code'] as String?,
        name = json['name'] as String?,
        symbol = json['symbol'] as String?,
        description = json['description'],
        status = json['status'] as int?,
        orgId = json['org_id'],
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'code' : code,
    'name' : name,
    'symbol' : symbol,
    'description' : description,
    'status' : status,
    'org_id' : orgId,
    'created_by' : createdBy,
    'updated_by' : updatedBy,
    'created_at' : createdAt,
    'updated_at' : updatedAt,
    'deleted_at' : deletedAt
  };
}

class TimezoneEFormat {
  int? id;
  String? format;

  TimezoneEFormat({
    this.id,
    this.format,
  });

  factory TimezoneEFormat.fromJson(Map<String, dynamic> json) =>
      TimezoneEFormat(
        id: json["id"],
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "format": format,
      };
}

class Languages {
  final int? id;
  final String? name;
  final String? description;
  final String? code;
  final int? status;
  final dynamic createdBy;
  final dynamic updatedBy;
  final String? createdAt;
  final dynamic updatedAt;
  final dynamic deletedAt;

  Languages({
    this.id,
    this.name,
    this.description,
    this.code,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Languages.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        description = json['description'] as String?,
        code = json['code'] as String?,
        status = json['status'] as int?,
        createdBy = json['created_by'],
        updatedBy = json['updated_by'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'],
        deletedAt = json['deleted_at'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'code': code,
        'status': status,
        'created_by': createdBy,
        'updated_by': updatedBy,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'deleted_at': deletedAt
      };
}

class ThemeSetting {
  int? id;
  int? branchId;
  InterfaceTheme? interfaceTheme;
  int? transparentSidebarStatus;
  AccentColor? accentColor;
  FontStyle? fontStyle;
  int? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  ThemeSetting({
    this.id,
    this.branchId,
    this.interfaceTheme,
    this.transparentSidebarStatus,
    this.accentColor,
    this.fontStyle,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ThemeSetting.fromJson(Map<String, dynamic> json) => ThemeSetting(
        id: json["id"],
        branchId: json["branch_id"],
        interfaceTheme: interfaceThemeValues.map[json["interface_theme"]]!,
        transparentSidebarStatus: json["transparent_sidebar_status"],
        accentColor: accentColorValues.map[json["accent_color"]]!,
        fontStyle: fontStyleValues.map[json["font_style"]]!,
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        deletedBy: json["deleted_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branch_id": branchId,
        "interface_theme": interfaceThemeValues.reverse[interfaceTheme],
        "transparent_sidebar_status": transparentSidebarStatus,
        "accent_color": accentColorValues.reverse[accentColor],
        "font_style": fontStyleValues.reverse[fontStyle],
        "created_by": createdBy,
        "updated_by": updatedBy,
        "deleted_by": deletedBy,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}

enum AccentColor {
  FF5982,
  THEME_DEFAULT,
  THEME_SOLID_GREEN,
  THEME_SOLID_GREEN_MEDIUM,
  THEME_SOLID_ORANGE,
  THEME_SOLID_PERIWINKLE_BLUE,
  THEME_SOLID_VIOLET_RED
}

final accentColorValues = EnumValues({
  "#FF5982": AccentColor.FF5982,
  "theme-default": AccentColor.THEME_DEFAULT,
  "theme-solid-green": AccentColor.THEME_SOLID_GREEN,
  "theme-solid-green-medium": AccentColor.THEME_SOLID_GREEN_MEDIUM,
  "theme-solid-orange": AccentColor.THEME_SOLID_ORANGE,
  "theme-solid-periwinkle-blue": AccentColor.THEME_SOLID_PERIWINKLE_BLUE,
  "theme-solid-violet-red": AccentColor.THEME_SOLID_VIOLET_RED
});

enum FontStyle {
  BEBASNEUE,
  DEFAULTFONT,
  GREATVIBES,
  IBMPLEXMONO,
  POPPINS,
  ROBOTOMONO
}

final fontStyleValues = EnumValues({
  "bebasneue": FontStyle.BEBASNEUE,
  "defaultfont": FontStyle.DEFAULTFONT,
  "greatvibes": FontStyle.GREATVIBES,
  "ibmplexmono": FontStyle.IBMPLEXMONO,
  "poppins": FontStyle.POPPINS,
  "robotomono": FontStyle.ROBOTOMONO
});

enum InterfaceTheme { DARK_MODE, LIGHT_MODE }

final interfaceThemeValues = EnumValues({
  "dark-mode": InterfaceTheme.DARK_MODE,
  "light-mode": InterfaceTheme.LIGHT_MODE
});

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? emailId;
  String? gender;
  String? maritalStatus;
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
  EmployeeType? employeeType;
  int? status;
  int? userImport;
  DateTime? createdAt;
  String? deviceToken;
  dynamic fcmToken;
  dynamic punchInImage;
  int? punchInStatus;
  String? userUniqueId;
  List<Role>? roles;

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
    this.userImport,
    this.createdAt,
    this.deviceToken,
    this.fcmToken,
    this.punchInImage,
    this.punchInStatus,
    this.userUniqueId,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"] == null ? "" : json["last_name"],
        emailId: json["email_id"],
        gender: json["gender"],
        maritalStatus: json["marital_status"],
        country: Country.fromJson(json["country"]),
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        state: State.fromJson(json["state"]),
        city: City.fromJson(json["city"]),
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
        employeeType: EmployeeType.fromJson(json["employee_type"]),
        status: json["status"],
        userImport: json["import"],
        createdAt: DateTime.parse(json["created_at"]),
        deviceToken: json["device_token"],
        fcmToken: json["fcm_token"],
        punchInImage: json["punch_in_image"],
        punchInStatus: json["punch_in_status"],
        userUniqueId: json["user_unique_id"],
        roles: json["roles"] == []
            ? json["roles"]
            : List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email_id": emailId,
        "gender": gender,
        "marital_status": maritalStatus,
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
        "import": userImport,
        "created_at": createdAt?.toIso8601String(),
        "device_token": deviceToken,
        "fcm_token": fcmToken,
        "punch_in_image": punchInImage,
        "punch_in_status": punchInStatus,
        "user_unique_id": userUniqueId,
        "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class City {
  int? id;
  String? name;
  int? stateId;
  String? stateCode;
  int? countryId;
  String? countryCode;
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
        countryCode: json["country_code"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "state_id": stateId,
        "state_code": stateCode,
        "country_id": countryId,
        "country_code": countryCode,
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Country {
  int? id;
  String? name;
  String? iso3;
  String? iso2;
  String? phoneCode;
  String? capital;
  String? currency;
  String? native;
  String? emoji;
  String? emojiU;
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
        iso3: json["iso3"],
        iso2: json["iso2"],
        phoneCode: json["phone_code"],
        capital: json["capital"],
        currency: json["currency"],
        native: json["native"],
        emoji: json["emoji"],
        emojiU: json["emojiU"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iso3": iso3,
        "iso2": iso2,
        "phone_code": phoneCode,
        "capital": capital,
        "currency": currency,
        "native": native,
        "emoji": emoji,
        "emojiU": emojiU,
        "created_at": createdAt?.toIso8601String(),
      };
}

class EmployeeType {
  String? id;
  String? type;

  EmployeeType({
    this.id,
    this.type,
  });

  factory EmployeeType.fromJson(Map<String, dynamic> json) => EmployeeType(
        id: json["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}

class Role {
  int? id;
  String? name;
  GuardName? guardName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? branchId;
  RolePivot? pivot;
  List<Permission>? permissions;

  Role({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.pivot,
    this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        guardName: guardNameValues.map[json["guard_name"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        branchId: json["branch_id"],
        pivot: RolePivot.fromJson(json["pivot"]),
        permissions: List<Permission>.from(
            json["permissions"].map((x) => Permission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guard_name": guardNameValues.reverse[guardName],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "branch_id": branchId,
        "pivot": pivot?.toJson(),
        "permissions": List<dynamic>.from(permissions!.map((x) => x.toJson())),
      };
}

enum GuardName { API }

final guardNameValues = EnumValues({"api": GuardName.API});

class Permission {
  int? id;
  int? moduleId;
  String? name;
  GuardName? guardName;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? branchId;
  PermissionPivot? pivot;

  Permission({
    this.id,
    this.moduleId,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.branchId,
    this.pivot,
  });

  factory Permission.fromJson(Map<String, dynamic> json) => Permission(
        id: json["id"],
        moduleId: json["module_id"],
        name: json["name"],
        guardName: guardNameValues.map[json["guard_name"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        branchId: json["branch_id"],
        pivot: PermissionPivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "module_id": moduleId,
        "name": name,
        "guard_name": guardNameValues.reverse[guardName],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "branch_id": branchId,
        "pivot": pivot?.toJson(),
      };
}

class PermissionPivot {
  int? roleId;
  int? permissionId;

  PermissionPivot({
    this.roleId,
    this.permissionId,
  });

  factory PermissionPivot.fromJson(Map<String, dynamic> json) =>
      PermissionPivot(
        roleId: json["role_id"],
        permissionId: json["permission_id"],
      );

  Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "permission_id": permissionId,
      };
}

class RolePivot {
  int? modelId;
  int? roleId;
  String? modelType;

  RolePivot({
    this.modelId,
    this.roleId,
    this.modelType,
  });

  factory RolePivot.fromJson(Map<String, dynamic> json) => RolePivot(
        modelId: json["model_id"],
        roleId: json["role_id"],
        modelType: json["model_type"],
      );

  Map<String, dynamic> toJson() => {
        "model_id": modelId,
        "role_id": roleId,
        "model_type": modelType,
      };
}

class State {
  int? id;
  String? name;
  int? countryId;
  String? countryCode;
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
        countryCode: json["country_code"],
        stateCode: json["state_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "country_id": countryId,
        "country_code": countryCode,
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
