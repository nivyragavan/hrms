class DependantModel {
  List<Dependant> dependant;

  DependantModel({required this.dependant});

  factory DependantModel.fromJson(List<dynamic> json) {
    List<Dependant> dependentsList = json.map((data) => Dependant.fromJson(data)).toList();
    return DependantModel(dependant: dependentsList);
  }

  List<Map<String, dynamic>> toJson() {
    return dependant.map((dependent) => dependent.toJson()).toList();
  }
}

class Dependant {
  String firstName;
  String lastName;
  String gender;
  String relationship;
  String phoneNumber;
  String emailAddress;

  Dependant({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.relationship,
    required this.phoneNumber,
    required this.emailAddress,
  });

  factory Dependant.fromJson(Map<String, dynamic> json) {
    return Dependant(
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      relationship: json['relationship'],
      phoneNumber: json['phone_number'],
      emailAddress: json['email_address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'relationship': relationship,
      'phone_number': phoneNumber,
      'email_address': emailAddress,
    };
  }
}
