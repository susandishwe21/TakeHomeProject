import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:take_home_app/res/controller/discover_controller.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            height: 300,
            child: SfDateRangePicker(
              view: DateRangePickerView.month,
              //showTodayButton: true,
              showActionButtons: true,
              cancelText: "Cancel",
              confirmText: "Ok",
              onCancel: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Selection Cancelled',
                  ),
                  duration: Duration(milliseconds: 500),
                ));
              },
              onSubmit: (value) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    'Selection Confirmed',
                  ),
                  duration: Duration(milliseconds: 500),
                ));
              },
            ),
          ),
        ),
        //  GetBuilder<DiscoverController>(builder: (controller) {
        //   if (controller.isSlotLoading.value) {
        //     return Center(child: CircularProgressIndicator());
        //   }
        //   return SfDateRangePicker(
        //     view: DateRangePickerView.month,
        //     //showTodayButton: true,
        //   );
        // }),
      ),
    );
  }
}
