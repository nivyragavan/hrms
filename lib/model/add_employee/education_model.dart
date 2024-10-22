class EducationModel {
  List<Education> education;

  EducationModel({required this.education});

  factory EducationModel.fromJson(Map<String, dynamic> json) {
    var educationList = json['education'] as List<dynamic>;
    List<Education> education =
    educationList.map((e) => Education.fromJson(e)).toList();

    return EducationModel(education: education);
  }

  Map<String, dynamic> toJson() {
    return {
      'education': education.map((contact) => contact.toJson()).toList(),
    };
  }
}

class Education{
  String? degree;
  String? specialization;
  String? university_name;
  String? gpa;
  String? start_year;
  String? end_year;

  Education({
    this.degree,
    this.specialization,
    this.university_name,
    this.gpa,
    this.start_year,
    this.end_year,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
   return Education(
     degree: json["degree"],
     specialization: json["specialization"],
     university_name: json["college_name"],
     gpa: json["gpa"],
     start_year: json["start_year"],//DateTime.parse(json["start_year"]),
     end_year: json["end_year"],//DateTime.parse(json["end_year"]),
   ) ;
  }

  Map<String, dynamic> toJson() => {
    "degree": degree,
    "specialization": specialization,
    "university_name": university_name,
    "gpa": gpa,
    "start_year": start_year,
    "end_year": start_year,
    // "start_year": start_year != null
    //     ? "${start_year!.year.toString().padLeft(4, '0')}-${start_year!.month.toString().padLeft(2, '0')}-${start_year!.day.toString().padLeft(2, '0')}"
    //     : null,//"${start_year?.year.toString().padLeft(4, '0')}-${start_year?.month.toString().padLeft(2, '0')}-${start_year.day.toString().padLeft(2, '0')}",
    // "end_year": end_year != null
    //     ? "${end_year!.year.toString().padLeft(4, '0')}-${end_year!.month.toString().padLeft(2, '0')}-${end_year!.day.toString().padLeft(2, '0')}"
    //     : null,//"${end_year?.year.toString().padLeft(4, '0')}-${end_year?.month.toString().padLeft(2, '0')}-${end_year.day.toString().padLeft(2, '0')}",
  };
}

