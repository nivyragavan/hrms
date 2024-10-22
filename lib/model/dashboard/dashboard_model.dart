class DashboardAdminModel {
  final String? code;
  final String? message;
  final Data? data;

  DashboardAdminModel({
    this.code,
    this.message,
    this.data,
  });

  DashboardAdminModel.fromJson(Map<String, dynamic> json)
      : code = json['code'] as String?,
        message = json['message'] as String?,
        data = (json['data'] as Map<String,dynamic>?) != null ? Data.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'code' : code,
    'message' : message,
    'data' : data?.toJson()
  };
}

class Data {
  final Employee? employee;

  Data({
    this.employee,
  });

  Data.fromJson(Map<String, dynamic> json)
      : employee = (json['employee'] as Map<String,dynamic>?) != null ? Employee.fromJson(json['employee'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'employee' : employee?.toJson()
  };
}

class Employee {
  final String? totalCount;
  final String? totalLastMonthEmpCount;
  final String? newEmployee;
  final String? lastMonthNewEmployee;
  final String? noOfLeave;
  final String? lastMonthNoOfLeave;
  final String? noOfAssets;
  final String? lastMonthNoOfAssets;

  Employee({
    this.totalCount,
    this.totalLastMonthEmpCount,
    this.newEmployee,
    this.lastMonthNewEmployee,
    this.noOfLeave,
    this.lastMonthNoOfLeave,
    this.noOfAssets,
    this.lastMonthNoOfAssets,
  });

  Employee.fromJson(Map<String, dynamic> json)
      : totalCount = json['total_count'] as String?,
        totalLastMonthEmpCount = json['total_last_month_emp_count'] as String?,
        newEmployee = json['new_employee'] as String?,
        lastMonthNewEmployee = json['last_month_new_employee'] as String?,
        noOfLeave = json['no_of_leave'] as String?,
        lastMonthNoOfLeave = json['last_month_no_of_leave'] as String?,
        noOfAssets = json['no_of_assets'] as String?,
        lastMonthNoOfAssets = json['last_month_no_of_assets'] as String?;

  Map<String, dynamic> toJson() => {
    'total_count' : totalCount,
    'total_last_month_emp_count' : totalLastMonthEmpCount,
    'new_employee' : newEmployee,
    'last_month_new_employee' : lastMonthNewEmployee,
    'no_of_leave' : noOfLeave,
    'last_month_no_of_leave' : lastMonthNoOfLeave,
    'no_of_assets' : noOfAssets,
    'last_month_no_of_assets' : lastMonthNoOfAssets
  };
}