// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

UserModel loginModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String loginModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? fullName;
    String? email;
    int? id;
    String? token;
    bool? hasSubscribableEntities;
    bool? isStaff;
    List<dynamic>? roles;
    Organizations? organizations;

    UserModel({
        this.fullName,
        this.email,
        this.id,
        this.token,
        this.hasSubscribableEntities,
        this.isStaff,
        this.roles,
        this.organizations,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        fullName: json["full_name"],
        email: json["email"],
        id: json["id"],
        token: json["token"],
        hasSubscribableEntities: json["has_subscribable_entities"],
        isStaff: json["is_staff"],
        roles: json["roles"] == null ? [] : List<dynamic>.from(json["roles"]!.map((x) => x)),
        organizations: json["organizations"] == null ? null : Organizations.fromJson(json["organizations"]),
    );

    Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "email": email,
        "id": id,
        "token": token,
        "has_subscribable_entities": hasSubscribableEntities,
        "is_staff": isStaff,
        "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
        "organizations": organizations?.toJson(),
    };
}

class Organizations {
    Organizations();

    factory Organizations.fromJson(Map<String, dynamic> json) => Organizations(
    );

    Map<String, dynamic> toJson() => {
    };
}
