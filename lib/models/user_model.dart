import 'dart:convert';

UserModel userModelFromJson(dynamic str) =>
    UserModel.fromJson(json.decode(str));
String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//   UserModel({
//      this.user,
//      this.token,
//   });
//
//   User? user;
//   String? token;
//
//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         user: User.fromJson(json["user"]),
//         token: json["token"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "user": user?.toJson(),
//         "token": token,
//       };
// }

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.password,
    this.email,
    this.address,
    this.rating,
    this.phone,
    this.typeJobId,
    this.status,
    this.role,
    this.updatedAt,
    this.createdAt,
    this.path,
    this.path_card,
    this.userId,
    this.remember_token,
    this.booking,
  });

  int? id;
  int? typeJobId;
  int? status;
  int? role;
  String? password;
  int? userId;
  String? name;
  String? address;
  int? rating;
  String? phone;
  String? email;
  String? path;
  String? path_card;
  int? booking;
  String? createdAt;
  String? updatedAt;
  String? remember_token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        rating: json["rating"],
        phone: json["phone"],
        typeJobId: json["type_job_id"],
        email: json["email"],
        path: json["path"],
        path_card: json["path_card"],
        status: json["status"],
        userId: json["user_id"],
        role: json["role"],
        password: json["password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        remember_token: json["remember_token"],
        booking: json["booking"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "rating": rating,
        "phone": phone,
        "type_job_id": typeJobId,
        "email": email,
        "path": path,
        "path_card": path_card,
        "status": status,
        "user_id": userId,
        "role": role,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "remember_token": remember_token,
        "booking": booking,
      };
}
