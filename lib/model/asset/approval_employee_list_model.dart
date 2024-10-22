class ApprovalModel {
  final List<Approval>? approval;

  ApprovalModel({
    this.approval,
  });

  ApprovalModel.fromJson(Map<String, dynamic> json)
      : approval = (json['approval'] as List?)
            ?.map((dynamic e) => Approval.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'approval': approval?.map((e) => e.toJson()).toList()};
}

class Approval {
  final String? id;
  final String? firstName;
  final String? lastName;

  Approval({
    this.id,
    this.firstName,
    this.lastName,
  });

  Approval.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        firstName = json['first_name'] as String?,
        lastName = json['last_name'] as String?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'first_name': firstName, 'last_name': lastName};
}
