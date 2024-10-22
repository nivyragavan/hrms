class DocumentModel {
  final Data1? data;

  DocumentModel({
    this.data,
  });

  DocumentModel.fromJson(Map<String, dynamic> json)
      :
        data = (json['data'] as Map<String,dynamic>?) != null ? Data1.fromJson(json['data'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {

    'data' : data?.toJson()
  };
}

class Data1 {
  final List<Data>? data;

  Data1({
    this.data,
  });

  Data1.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final int? id;
  final int? userId;
  final String? docDescription;
  final dynamic docStatus;
  final String? docName;
  final String? documentUrl;

  Data({
    this.id,
    this.userId,
    this.docDescription,
    this.docStatus,
    this.docName,
    this.documentUrl,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        docDescription = json['doc_description'] as String?,
        docStatus = json['doc_status'],
        docName = json['doc_name'] as String?,
        documentUrl = json['document_url'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'user_id' : userId,
    'doc_description' : docDescription,
    'doc_status' : docStatus,
    'doc_name' : docName,
    'document_url' : documentUrl
  };
}