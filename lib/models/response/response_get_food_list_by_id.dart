// To parse this JSON data, do
//
//     final responseGetFoodListById = responseGetFoodListByIdFromJson(jsonString);

import 'dart:convert';

import 'package:task/models/response/restaurant.dart';

ResponseGetFoodListById responseGetFoodListByIdFromJson(String str) => ResponseGetFoodListById.fromJson(json.decode(str));

String responseGetFoodListByIdToJson(ResponseGetFoodListById data) => json.encode(data.toJson());

class ResponseGetFoodListById {
  ResponseGetFoodListById({
    required this.code,
    required this.msg,
    required this.data,
  });

  int code;
  String msg;
  List<Restaurant> data;

  factory ResponseGetFoodListById.fromJson(Map<String, dynamic> json) => ResponseGetFoodListById(
    code: json["code"],
    msg: json["msg"],
    data: List<Restaurant>.from(json["data"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

