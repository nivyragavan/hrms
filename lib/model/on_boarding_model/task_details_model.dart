class TaskDetailsModel {
  List<TaskDetails> taskDetails;

  TaskDetailsModel({required this.taskDetails});

  factory TaskDetailsModel.fromJson(Map<String, dynamic> json) {
    var taskDetailsList = json['taskDetails'] as List<dynamic>;
    List<TaskDetails> taskDetails =
    taskDetailsList.map((e) => TaskDetails.fromJson(e)).toList();

    return TaskDetailsModel(taskDetails: taskDetails);
  }

  Map<String, dynamic> toJson() {
    return {
      'taskDetails': taskDetails.map((contact) => contact.toJson()).toList(),
    };
  }
}

class TaskDetails{
  int? id;
  String? fieldType;
  String? answer;

  TaskDetails({
    this.id,
    this.fieldType,
    this.answer,
  });

  factory TaskDetails.fromJson(Map<String, dynamic> json) {
    return TaskDetails(
      id: json["id"],
      fieldType: json["fieldType"],
      answer: json["answer"],
    ) ;
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "fieldType":fieldType,
    "answer": answer,
  };
}

