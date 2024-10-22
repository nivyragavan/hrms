// To parse this JSON data, do
//
//     final face = faceFromJson(jsonString);

import 'dart:convert';

List<FaceDetails> faceListFromJson(String str) => List<FaceDetails>.from(
    json.decode(str).map((x) => FaceDetails.fromJson(x)));

String faceListToJson(List<FaceDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaceDetails {
  int id;
  String firstName;
  String lastName;
  String punchInImage;
  int punchInStatus;
  String userUniqueId;
  JobPosition jobPosition;

  FaceDetails({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.punchInImage,
    required this.punchInStatus,
    required this.userUniqueId,
    required this.jobPosition,
  });

  factory FaceDetails.fromJson(Map<String, dynamic> json) => FaceDetails(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        punchInImage: json["punch_in_image"],
        punchInStatus: json["punch_in_status"],
        userUniqueId: json["user_unique_id"],
        jobPosition: JobPosition.fromJson(json["job_position"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "punch_in_image": punchInImage,
        "punch_in_status": punchInStatus,
        "user_unique_id": userUniqueId,
      };
}

class JobPosition {
  Position position;

  JobPosition({
    required this.position,
  });

  factory JobPosition.fromJson(Map<String, dynamic> json) => JobPosition(
        position: Position.fromJson(json["position"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position.toJson(),
      };
}

class Position {
  String positionName;

  Position({
    required this.positionName,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        positionName: json["position_name"],
      );

  Map<String, dynamic> toJson() => {
        "position_name": positionName,
      };
}
