// To parse this JSON data, do
//
//     final requestGetFoodListById = requestGetFoodListByIdFromJson(jsonString);

import 'dart:convert';

RequestGetFoodListById requestGetFoodListByIdFromJson(String str) => RequestGetFoodListById.fromJson(json.decode(str));

String requestGetFoodListByIdToJson(RequestGetFoodListById data) => json.encode(data.toJson());

class RequestGetFoodListById {
  RequestGetFoodListById({
    required this.token,
    required this.id,
    required this.cityId,
    required this.pageNumber,
    required this.pageCount,
  });

  String token;
  int id;
  int cityId;
  int pageNumber;
  int pageCount;

  factory RequestGetFoodListById.fromJson(Map<String, dynamic> json) => RequestGetFoodListById(
    token: json["token"],
    id: json["id"],
    cityId: json["cityId"],
    pageNumber: json["pageNumber"],
    pageCount: json["pageCount"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "id": id,
    "cityId": cityId,
    "pageNumber": pageNumber,
    "pageCount": pageCount,
  };
}
