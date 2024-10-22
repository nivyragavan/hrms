class LeaveApprovalSettingsModel {
  final String? approverId;
  final String? approverLevel;
  LeaveApprovalSettingsModel({
    this.approverId,
    this.approverLevel,
  });

  LeaveApprovalSettingsModel.fromJson(Map<String, dynamic> json)
      : approverId = json['approver_id'] as String?,
        approverLevel = json['approver_list'] as String?;

  Map<String, dynamic> toJson() => {
        'approver_id': approverId,
        'approver_list': approverLevel,
      };
}
