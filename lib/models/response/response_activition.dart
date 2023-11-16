import 'dart:convert';

ResponseActivation responseActivationFromJson(String str) => ResponseActivation.fromJson(json.decode(str));

String responseActivationToJson(ResponseActivation data) => json.encode(data.toJson());

class ResponseActivation {
  ResponseActivation({
    required this.code,
    required this.msg,
    required this.data,
  });

  int code;
  String msg;
  Data data;

  factory ResponseActivation.fromJson(Map<String, dynamic> json) => ResponseActivation(
    code: json["code"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.mobile,
    required this.isRegistered,
    required this.token,
  });

  String mobile;
  int isRegistered;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    mobile: json["mobile"],
    isRegistered: json["isRegistered"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "mobile": mobile,
    "isRegistered": isRegistered,
    "token": token,
  };
}
