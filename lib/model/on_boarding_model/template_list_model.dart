import 'dart:convert';

TemplateListModel templateListModelFromJson(String str) => TemplateListModel.fromJson(json.decode(str));

String templateListModelToJson(TemplateListModel data) => json.encode(data.toJson());

class TemplateListModel {
  String? code;
  String? message;
  Data? data;

  TemplateListModel({
    this.code,
    this.message,
    this.data,
  });

  factory TemplateListModel.fromJson(Map<String, dynamic> json) => TemplateListModel(
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
  List<Datum>? data;

  Data({
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? templateName;
  String? description;
  int? type;
  int? createdBy;
  List<Task>? task;

  Datum({
    this.id,
    this.templateName,
    this.description,
    this.type,
    this.createdBy,
    this.task,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    templateName: json["template_name"],
    description: json["description"],
    type: json["type"],
    createdBy: json["created_by"],
    task: List<Task>.from(json["task"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "template_name": templateName,
    "description": description,
    "type": type,
    "created_by": createdBy,
    "task": List<dynamic>.from(task!.map((x) => x.toJson())),
  };
}

class Task {
  int? id;
  String? taskName;
  String? taskType;
  String? assignRole;
  String? description;
  int? noOfDays;
  String? dueDate;
  int? createdBy;
  int? templateId;
  List<TaskForm>? taskForm;

  Task({
    this.id,
    this.taskName,
    this.taskType,
    this.assignRole,
    this.description,
    this.noOfDays,
    this.dueDate,
    this.createdBy,
    this.templateId,
    this.taskForm,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    taskName: json["task_name"],
    taskType: json["task_type"],
    assignRole: json["assign_role"],
    description: json["description"],
    noOfDays: json["no_of_days"],
    dueDate: json["due_date"],
    createdBy: json["created_by"],
    templateId: json["template_id"],
    taskForm: List<TaskForm>.from(json["task_form"].map((x) => TaskForm.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_name": taskName,
    "task_type": taskType,
    "assign_role": assignRole,
    "description": description,
    "no_of_days": noOfDays,
    "due_date": dueDate,
    "created_by": createdBy,
    "template_id": templateId,
    "task_form": List<dynamic>.from(taskForm!.map((x) => x.toJson())),
  };
}

class TaskForm {
  int? id;
  int? taskId;
  String? fieldType;
  String? fieldName;
  String? placeholder;
  dynamic options;
  int? createdBy;

  TaskForm({
    this.id,
    this.taskId,
    this.fieldType,
    this.fieldName,
    this.placeholder,
    this.options,
    this.createdBy,
  });

  factory TaskForm.fromJson(Map<String, dynamic> json) => TaskForm(
    id: json["id"],
    taskId: json["task_id"],
    fieldType: json["field_type"],
    fieldName: json["field_name"],
    placeholder: json["placeholder"],
    options: json["options"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_id": taskId,
    "field_type": fieldType,
    "field_name": fieldName,
    "placeholder": placeholder,
    "options": options,
    "created_by": createdBy,
  };
}
