import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:take_home_app/res/controller/network.dart';
import 'package:take_home_app/res/model/slot.dart';

class DiscoverController extends GetxController {
  RxBool isSlotLoading = false.obs;
  List<AppointmentsSlot>? appointmentsSlot;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  getAppointmentsSlot() async {
    isSlotLoading.value = true;
    update();
    await Network().fetchSlots().then(
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
        }
      },
    );

    isSlotLoading.value = false;
    update();
  }
}
