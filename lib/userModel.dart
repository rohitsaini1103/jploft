// To parse this JSON data, do
//
//     final UserModel = UserModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel UserModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String UserModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.meta,
    required this.data,
  });

  Meta meta;
  List<Datum> data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    meta: Meta.fromJson(json["meta"]),
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "meta": meta.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  int id;
  String name;
  String email;
  String gender;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    gender: json["gender"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "gender": gender,
    "status": status,
  };
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    pagination: Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "pagination": pagination.toJson(),
  };
}

class Pagination {
  Pagination({
    required this.total,
    required this.pages,
    required this.page,
    required this.limit,
    required this.links,
  });

  int total;
  int pages;
  int page;
  int limit;
  Links links;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    pages: json["pages"],
    page: json["page"],
    limit: json["limit"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "pages": pages,
    "page": page,
    "limit": limit,
    "links": links.toJson(),
  };
}

class Links {
  Links({
    required this.previous,
    required this.current,
    required this.next,
  });

  dynamic previous;
  String current;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    previous: json["previous"],
    current: json["current"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "previous": previous,
    "current": current,
    "next": next,
  };
}
