import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:take_home_app/res/controller/network.dart';
import 'package:take_home_app/res/model/price.dart';
import 'package:take_home_app/res/model/slot.dart';

class DiscoverController extends GetxController {
  RxBool isSlotLoading = false.obs;
  RxBool isPriceLoading = false.obs;
  List<AppointmentsSlot>? appointmentsSlot;
  TotalPrice? totalPrice;
  var dateTime = DateTime.parse(DateTime.now().toString());
  var parsedDate;
  var slotIndex;
  Map<String, dynamic> dataList = new Map<String, dynamic>();
  Map<String, dynamic> priceList = new Map<String, dynamic>();

  @override
  void onInit() {
    super.onInit();
  }

  //call network call for get all appointment slots with each datetime
  getAppointmentsSlot(dateTime) async {
    isSlotLoading.value = true;
    update();
    parsedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
    debugPrint("Date : $parsedDate");
    slotIndex =
        appointmentsSlot?.indexWhere((element) => element.date == dateTime) ??
            -1;
    await Network().fetchSlots(parsedDate).then(
      (value) {
        var statusCode = 0;
        if (value is DioError) {
          statusCode = value.response!.statusCode!;
        } else {
          statusCode = value.statusCode;
        }
        if (statusCode == 200 || statusCode == 201) {
          var data = utf8.decode(value.data!);
          appointmentsSlot = appointmentsSlotFromJson(data.toString());
          update();
        }
      },
    );

    isSlotLoading.value = false;
    update();
  }

//call network call for get all price
  getAllPrice() async {
    isPriceLoading.value = true;
    update();

    await Network().fetchAllPrice().then(
      (value) {
        var statusCode = 0;
        if (value is DioError) {
          statusCode = value.response!.statusCode!;
        } else {
          statusCode = value.statusCode;
        }
        if (statusCode == 200 || statusCode == 201) {
          var data = jsonDecode(utf8.decode(value.data!));
          //totalPrice = totalPriceFromJson(jsonDecode(data.toString()));
          dataList = data['prices'];
          priceList = data['prices']['ounce'];
          debugPrint("DataList : $dataList");
          debugPrint("Ounce : ${data['prices']['ounce']}");
          update();
        }
      },
    );

    isPriceLoading.value = false;
    update();
  }
}
