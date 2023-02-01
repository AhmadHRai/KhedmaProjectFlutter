import 'dart:convert';

List<TypeJobsModel> typeJobsModelFromJson(dynamic str) => List<TypeJobsModel>.from(json.decode(str).map((x) => TypeJobsModel.fromJson(x)));

String typeJobsModelToJson(List<TypeJobsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TypeJobsModel {
  TypeJobsModel({
    this.id,
    this.name,
    this.path,
    // this.jobsModel,
    // this.createdAt,
    // this.updatedAt,
  });

  int? id;
  String? name;
  String? path;
  // JobsModel? jobsModel;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  factory TypeJobsModel.fromJson(Map<String, dynamic> json) => TypeJobsModel(
    id: json["id"],
    name: json["name"],
    path: json["path"],
    // jobsModel: JobsModel.fromJson(json["type_job_id"]),
    // createdAt: json["created_at"],
    // updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "path": path,
    // "created_at": createdAt,
    // "updated_at": updatedAt,
  };
}
