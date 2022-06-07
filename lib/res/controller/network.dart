import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:take_home_app/res/model/api/api.dart';

class Network {
  Future<dynamic> fetchAllPrice() async {
    try {
      var response = await Dio().get(
        getAllPrice,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      debugPrint("Response Price : ${response.statusCode}");
      return response;
    } catch (e) {
      if (e is DioError) {
        debugPrint("Response Price : ${e.message}");
      }
      return e;
    }
  }

  Future<dynamic> fetchSlots() async {
    try {
      var response = await Dio().get(
        getSlots,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      debugPrint("Response Slots : ${response.statusCode}");
      return response;
    } catch (e) {
      if (e is DioError) {
        debugPrint("Response Slots : ${e.message}");
      }
      return e;
    }
  }
}
