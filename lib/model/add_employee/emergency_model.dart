class EmergencyContactModel {
  List<EmergencyContact> emergency;

  EmergencyContactModel({required this.emergency});

  factory EmergencyContactModel.fromJson(Map<String, dynamic> json) {
    var emergencyList = json['emergency'] as List<dynamic>;
    List<EmergencyContact> emergencyContacts =
        emergencyList.map((e) => EmergencyContact.fromJson(e)).toList();

    return EmergencyContactModel(emergency: emergencyContacts);
  }

  Map<String, dynamic> toJson() {
    return {
      'emergency': emergency.map((contact) => contact.toJson()).toList(),
    };
  }
}

class EmergencyContact {
  String relationEmailAddress;
  String relationFirstName;
  String relationLastName;
  String phoneNumber;
  String relationship;

  EmergencyContact({
    required this.relationEmailAddress,
    required this.relationFirstName,
    required this.relationLastName,
    required this.phoneNumber,
    required this.relationship,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      relationEmailAddress: json['relation_email_address'] ?? "",
      relationFirstName: json['relation_first_name'] ?? "",
      relationLastName: json['relation_last_name'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      relationship: json['relationship'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relation_email_address': relationEmailAddress,
      'relation_first_name': relationFirstName,
      'relation_last_name': relationLastName,
      'phone_number': phoneNumber,
      'relationship': relationship,
    };
  }
}
