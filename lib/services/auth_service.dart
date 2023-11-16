import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../models/response/response_activition.dart';
import '../models/response/response_get_food_list_by_id.dart';
import '../utils/Constant.dart';
//-----------------------------------------------

class AuthService{

//-----------------------------------------------
  Future<ResponseActivation> sendDataForConfirmCode(Map body) async{

    final response = await Dio().post(
        '${Constant.baseUrl}Users/activeCode',
        data: body);

    log('sendDataForConfirmCode server ${response.data}');
    final resultActivation = responseActivationFromJson(response.data);
    return resultActivation;

  }
//-----------------------------------------------

  Future<ResponseGetFoodListById> getFoodListById(Map body) async {
    final response = await Dio().post(
        '${Constant.baseUrl}Foods/getFoodListById'
       // 'http://offood24.ir/api/Foods/getFoodListById'
        ,data: body);

    log('getFoodListById server ${response.data}');
    final resultGetFoodListById = responseGetFoodListByIdFromJson(response.data);
    return resultGetFoodListById;

  }

}