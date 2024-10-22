import '../constants/config.dart';

class Api {
  static const login = AppConfig.baseUrl + "/login";
  static const countryList = AppConfig.baseUrl + "/countryList";
  static const register = AppConfig.baseUrl + "/company-register";
  static const forgotPassword = AppConfig.baseUrl + "/forgot-password";
  static const employeeList = AppConfig.baseUrl + "/employee/list";

  ///Particular emp personal information
  static const profileList = AppConfig.baseUrl + "/employee/profile";
  static const employeeTeamList = AppConfig.baseUrl + "/employee/teams";
  static const documentList = AppConfig.baseUrl + "/employee/documents";
  static const assets = AppConfig.baseUrl + "/asset/employee-assets";
  static const time_off = AppConfig.baseUrl + "/time-off-request-list";
  static const timeSheet = AppConfig.baseUrl + "/timesheet";
  static const departmentList = AppConfig.baseUrl + "/department/list";
  static const departmentDataUpload = AppConfig.baseUrl + "/department/save";
  static const departmentIconUpload =
      AppConfig.baseUrl + "/department/iconUpload";
  static const gradeList = AppConfig.baseUrl + "/grade-list";
  static const editDepartment = AppConfig.baseUrl + "/editDepartment";
  static const shiftList = AppConfig.baseUrl + "/shift/list";
  static const scheduleList = AppConfig.baseUrl + "/schedulelist";
  static const addShift = AppConfig.baseUrl + "/shift/save";
  // static const assignSchedule = AppConfig.baseUrlms1 + "/assign-schedule";
  static const updateSchedule = AppConfig.baseUrl + "/update-schedule";
  static const Master = AppConfig.baseUrl + "/user_master";
  static const stateList = AppConfig.baseUrl + "/countrywiseStateList";
  static const cityList = AppConfig.baseUrl + "/statewiseCityList";
  static const addEmployee = AppConfig.baseUrl + "/add/employee";
  static const lineManagerList = AppConfig.baseUrl + "/usersList";
  static const role = AppConfig.baseUrl + "/roles";
  static const uploadEmployeeDetails =
      AppConfig.baseUrl + "/add/employeeInfo";
  static const dependencyupload = AppConfig.baseUrl + "/add/dependantInfo";
  static const educationUpload = AppConfig.baseUrl + "/add/educationInfo";
  static const documentsUpload = AppConfig.baseUrl + "/add/documentInfo";
  static const adminTeamList = AppConfig.baseUrl + "/employee/admin/teams";

  static const leaveType = AppConfig.baseUrl + "/leaveTypes";
  static const addLeave = AppConfig.baseUrl + "/leave/save";
  static const leaveAttachment = AppConfig.baseUrl + "/leave/attachment";
  static const leaveMaster = AppConfig.baseUrl + "/leaveMaster";
  static const addHoliday = AppConfig.baseUrl + "/holiday/save";
  static const deleteHoliday = AppConfig.baseUrl + "/holiday/delete";
  static const addProfileImage = AppConfig.baseUrl + "/add/profileImage";
  static const leaveHistory = AppConfig.baseUrl + "/leave/service/history";
  static const adminAttendance = AppConfig.baseUrl + "/admin/attendance";
  static const holidayList = AppConfig.baseUrl + "/holiday/list";
  static const leaveAction = AppConfig.baseUrl + "/leave/updateLeaveRequest";
  static const adminTimeSheet = AppConfig.baseUrl + "/timesheet/admin";

  static const positionStatusChange =
      AppConfig.baseUrl + "/department/changeStatus";
  static const employeeStatus = AppConfig.baseUrl + "/empChangeStatus";
  static const empOffBoarding = AppConfig.baseUrl + "/employee/off-boarding";

  static const branchList = AppConfig.baseUrl + "/branch/index";

  ///on/off boarding template apis
  static const templateAdd = AppConfig.baseUrl + "/template/add";
  static const templateEdit = AppConfig.baseUrl + "/template/edit";
  static const templateList = AppConfig.baseUrl + "/template/list";
  static const templateDelete = AppConfig.baseUrl + "/template/delete";

  ///on/off boarding task apis
  static const taskAdd = AppConfig.baseUrl + "/task/add";
  static const taskEdit = AppConfig.baseUrl + "/task/edit";
  static const taskList = AppConfig.baseUrl + "/task/list";
  static const taskDelete = AppConfig.baseUrl + "/task/delete";
  static const taskType = AppConfig.baseUrl + "/task/type";
  static const taskRole = AppConfig.baseUrl + "/task/role";
  static const customField = AppConfig.baseUrl + "/task/custom-field";

  ///Settings
  ///NOTIFICATION
  static const notificationSettingsList = AppConfig.baseUrl + "/settings/notification-list";
  static const notificationSave = AppConfig.baseUrl + "/settings/notification-save";
  ///COMPANY
  static const companySettingsList = AppConfig.baseUrl + "/settings/company/list";
  static const companySave = AppConfig.baseUrl + "/settings/company-save";
  static const companyLogoUpload = AppConfig.baseUrl + "/settings/companylogo/save";

  static const organizationDelete = AppConfig.baseUrl + "/settings/delete-organization";
  static const updateDashboardSettings = AppConfig.baseUrl + "/settings/dashboard";
  static const dashboardSettingsList = AppConfig.baseUrl + "/settings/dashboard-list";

  ///leave settings
  static const addLeaveSettingsType = AppConfig.baseUrl + "/settings/leave-add";
  static const editLeaveSettingsType = AppConfig.baseUrl + "/settings/leave-edit";
  static const addLeaveSettingsPolicy = AppConfig.baseUrl + "/settings/custom/policy/save";
  static const updateLeaveSettingsPolicy = AppConfig.baseUrl + "/settings/custom/policy/update";
  static const leaveSettingsList = AppConfig.baseUrl + "/settings/leave-list";
  static const approvalLeaveSettings = AppConfig.baseUrl + "/settings/leave-approval";
  static const userMaster = AppConfig.baseUrl + "/approve/user/master";
  ///asset Details
  static const adminAssetList = AppConfig.baseUrl + "/asset/index";
  static const assetStatus = AppConfig.baseUrl + "/asset/status";
  static const addAsset = AppConfig.baseUrl + "/asset/store";
  static const editAsset = AppConfig.baseUrl + "/asset/update";
  static const deleteAsset = AppConfig.baseUrl + "/asset/delete";
  static const addAssetAttachment =
      AppConfig.baseUrl + "/asset/image-upload";
  static const assignAsset = AppConfig.baseUrl + "/asset/assign-asset";
  static const assetColumnList = AppConfig.baseUrl + "/asset/columns";
  static const assetGetCode = AppConfig.baseUrl + "/asset/getcode";

  ///checklist apis
  static const checklist = AppConfig.baseUrl + "/check-list";
  static const checklistAssign = AppConfig.baseUrl + "/check-list/assign";
  static const checklistAssignList = AppConfig.baseUrl + "/check-list/assign-list";
  static const userTaskAnswer = AppConfig.baseUrl + "/user-task/answer";

  ///branch apis
  static const branchesList = AppConfig.baseUrl + "/branch/list";
  static const geoFencingStatusChange = AppConfig.baseUrl + "/branch/status-change";
  static const statusChange = AppConfig.baseUrl + "/branch/delete";
  static const setAsHQ = AppConfig.baseUrl + "/branch/set-hq";
  static const deleteBranch = AppConfig.baseUrl + "/branch/delete";

  static const manualPunch = AppConfig.baseUrl + "/punchin-out";
  static const employeeAttendance = AppConfig.baseUrl + "/employee/attendance";
  static const addBranch = AppConfig.baseUrl + "/branch/store";
  static const addBranchAttachment = AppConfig.baseUrl + "/branch/icon-upload";
  static const branchRadiusList = AppConfig.baseUrl + "/branch/radius-list";

  ///role
  static const roleSettingsList = AppConfig.baseUrl + "/role/list";
  static const rolePermissionSettingsList =
      AppConfig.baseUrl + "/permissions";
  static const roleModuleList = AppConfig.baseUrl + "/modules";
  static const roleAssignPermission =
      AppConfig.baseUrl + "/role/assign-permission";
  static const addRole = AppConfig.baseUrl + "/role/add";
  static const editRole = AppConfig.baseUrl + "/role/edit";
  static const deleteRole = AppConfig.baseUrl + "/role/delete";

  static const translateLanguageList = AppConfig.baseUrl + "/language/";

  ///System settings
  static const systemList=AppConfig.baseUrl+ "/settings/system/list";
  static const systemSave=AppConfig.baseUrl+ "/settings/system/save";
  static const timeZoneList=AppConfig.baseUrl+ "/timezoneList";
  static const dateTimeFormatList=AppConfig.baseUrl+ "/dateTimeFormat";
  static const languageList=AppConfig.baseUrl+ "/languagesList";
  static const currencyList=AppConfig.baseUrl+ "/currencyList";
  static const approvalList =AppConfig.baseUrl+ "/settings/leave-approval-list";

  ///announcement apis
  static const announcementList = AppConfig.baseUrl + "/announcement/list";
  static const announcementAdd = AppConfig.baseUrl + "/announcement/add";
  static const announcementEdit= AppConfig.baseUrl + "/announcement/edit";
  static const announcementDelete = AppConfig.baseUrl + "/announcement/delete";
  static const imageUpload = AppConfig.baseUrl + "/announcement/icon-upload";
  static const userAssign = AppConfig.baseUrl + "/announcement/assign";
  static const departmentAssign = AppConfig.baseUrl + "/announcement/assign";
  static const positionAssign = AppConfig.baseUrl + "/announcement/assign";

///dashboard
  static const dashboardAdmin = AppConfig.baseUrl + "/dashboard/admin";
  ///announcement
  static const announcementView = AppConfig.baseUrl + "/announcement/view";
  static const jobPosition = AppConfig.baseUrl + "/JobPosition";
  static const createPosition = AppConfig.baseUrl + "/announcement/assign";

  static const empAnnouncementList = AppConfig.baseUrl + "/announcement/user-list";
  static const empAnnouncementView = AppConfig.baseUrl + "/announcement/user-view";

  //Policies
  static const policiesList=AppConfig.baseUrl+ "/policy/list";
  static const policiesSave=AppConfig.baseUrl+ "/policy/save";

  //face reco
  static const faceList = AppConfig.baseUrl + "/facelogin/list";
  static const changeFaceStatus = AppConfig.baseUrl + "/facelogin/update";
  static const addFace = AppConfig.baseUrl + "/facelogin/store";
  static const getFaceStatus = AppConfig.baseUrl + "/facelogin/status";
  static const verifyFace = AppConfig.pythonFaceRecoServerUrl + "/face_recognition/users/compare_images";
}
