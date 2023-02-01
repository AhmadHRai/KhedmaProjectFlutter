// To parse this JSON data, do
//
//     final jobsModel = jobsModelFromJson(jsonString);

import 'dart:convert';

List<JobsModel> jobsModelFromJson(String str) => List<JobsModel>.from(json.decode(str).map((x) => JobsModel.fromJson(x)));

String jobsModelToJson(List<JobsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobsModel {
  JobsModel({
    this.id,
    this.name,
    this.email,
    // this.emailVerifiedAt,
    this.phone,
    this.address,
    this.path,
    // this.status,
    // this.userId,
    this.rating,
    this.booking,
    // this.role,
    // this.createdAt,
    // this.updatedAt,
    // this.typeJobId,
  });

  int? id;
  String? name;
  String? email;
  // String? emailVerifiedAt;
  String? phone;
  String? address;
  String? path;
  String? booking;
  // String? status;
  // String? userId;
  String? rating;
  // String? role;
  // String? createdAt;
  // String? updatedAt;
  // TypeJobId? typeJobId;

  factory JobsModel.fromJson(Map<String, dynamic> json) => JobsModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    // emailVerifiedAt: json["email_verified_at"],
    phone: json["phone"],
    address: json["address"],
    path: json["path"],
    booking: json["booking"],
    // status: json["status"],
    // userId: json["user_id"],
    rating: json["rating"],
    // role: json["role"],
    // createdAt: json["created_at"],
    // updatedAt: json["updated_at"],
    // typeJobId: TypeJobId.fromJson(json["type_job_id"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    // "email_verified_at": emailVerifiedAt,
    // "phone": phone,
    "address": address,
    // "path": path,
    // "status": status,
    // "user_id": userId,
    "rating": rating,
    // "role": role,
    // "created_at": createdAt,
    // "updated_at": updatedAt,
    // "type_job_id": typeJobId?.toJson(),
  };
}

class TypeJobId {
  TypeJobId({
    this.id,
    this.name,
    this.path,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? path;
  String? createdAt;
  String? updatedAt;

  factory TypeJobId.fromJson(Map<String, dynamic> json) => TypeJobId(
    id: json["id"],
    name: json["name"],
    path: json["path"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "path": path,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}