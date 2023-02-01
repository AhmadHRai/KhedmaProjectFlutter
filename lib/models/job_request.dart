import 'dart:convert';

List<JobRequest> jobRequestFromJson(String str) => List<JobRequest>.from(json.decode(str).map((x) => JobRequest.fromJson(x)));

String jobRequestToJson(List<JobRequest> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobRequest {
  JobRequest({
    this.id,
    this.title,
    this.price,
    this.dateStart,
    this.dateEnd,
    this.status,
    this.userIdW,
    this.userIdC,
    this.updatedAt,
    this.createdAt,
  });

  int? id;
  String? title;
  String? price;
  String? dateStart;
  String? dateEnd;
  String? status;
  String? userIdW;
  String? userIdC;
  String? updatedAt;
  String? createdAt;

  factory JobRequest.fromJson(Map<String, dynamic> json) => JobRequest(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    dateStart: json["date_start"],
    dateEnd: json["date_end"],
    status: json["status"],
    userIdW: json["user_id_w"],
    userIdC: json["user_id_c"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "date_start": dateStart,
    "date_end": dateEnd,
    "status": status,
    "user_id_w": userIdW,
    "user_id_c": userIdC,
    "updated_at": updatedAt,
    "created_at": createdAt,
  };
}
