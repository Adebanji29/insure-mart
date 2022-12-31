import 'dart:convert';

class UserModel {
  UserModel({
    this.uid,
    this.firstname,
    this.lastname,
    this.email,
    this.title,
    this.gender,
    this.dob,
    this.hAddress,
    this.imgUrl,
  });

  final String? uid;
  final String? firstname;
  final String? lastname;
  final String? email;
  final String? title;
  final String? gender;
  final String? dob;
  final String? hAddress;
  final String? imgUrl;

  UserModel copyWith({
    String? uid,
    String? firstname,
    String? lastname,
    String? email,
    String? title,
    String? gender,
    String? dob,
    String? hAddress,
    String? imgUrl,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        firstname: firstname ?? this.firstname,
        lastname: lastname ?? this.lastname,
        email: email ?? this.email,
        title: title ?? this.title,
        gender: gender ?? this.gender,
        dob: dob ?? this.dob,
        hAddress: hAddress ?? this.hAddress,
        imgUrl: imgUrl ?? this.imgUrl,
      );

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        uid: json["uid"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        email: json["email"],
        title: json["title"],
        gender: json["gender"],
        dob: json["dob"],
        hAddress: json["hAddress"],
        imgUrl: json["imgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "title": title,
        "gender": gender,
        "dob": dob,
        "hAddress": hAddress,
        "imgUrl": imgUrl,
      };
  UserModel dispose() => UserModel(
        uid: null,
        firstname: null,
        lastname: null,
        email: null,
        title: null,
        gender: null,
        dob: null,
        hAddress: null,
        imgUrl: null,
      );
}
