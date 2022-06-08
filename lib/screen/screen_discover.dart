import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:take_home_app/res/controller/discover_controller.dart';
import 'package:take_home_app/res/value.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CarouselScreen(),
              AppointmentScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class CarouselScreen extends StatelessWidget {
  const CarouselScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: GetBuilder<DiscoverController>(builder: (controller) {
          return CarouselSlider.builder(
            itemCount: controller.dataList.length,
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              String key = controller.dataList.keys.elementAt(itemIndex);

              return SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(key.toString().toUpperCase()),
                    ListView.builder(
                        itemCount: controller.priceList.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          String priceKey =
                              controller.priceList.keys.elementAt(index);
                          String priceValue = controller.priceList.values
                              .elementAt(index)
                              .toString();

                          return Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(priceKey.toString().toUpperCase()),
                                Text(priceValue)
                              ],
                            ),
                          );
                        }))
                  ],
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              aspectRatio: 2.0,
              initialPage: 2,
            ),
          );
        }),
      ),
    );
  }
}

/*Show appointment slot with each day and time */
class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 300,
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            showActionButtons: true,
            cancelText: "Cancel",
            confirmText: "Ok",
            onCancel: () {},
            onSubmit: (value) {
              Get.find<DiscoverController>().getAppointmentsSlot(value);
            },
          ),
        ),
        //Display available and unavailable color
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: TestColor().primaryColor,
                  size: 18,
                ),
                const Text("Available"),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.grey[500],
                  size: 18,
                ),
                const Text("UnAvailable"),
              ],
            )
          ],
        ),

        GetBuilder<DiscoverController>(
          builder: (controller) {
            //add loading for slot api
            if (controller.isSlotLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                ),
              );
            }

            debugPrint("Slot Index : ${controller.slotIndex}");
            //Retrieve appointment slot with each date and times
            return Flexible(
              child: controller.slotIndex == -1
                  ? const SizedBox(
                      height: 30,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Data isn't available"),
                      ),
                    )
                  : SizedBox(
                      height: 30,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: controller
                              .appointmentsSlot?[controller.slotIndex]
                              .slots
                              .length,
                          itemBuilder: (context, index) {
                            bool availableDate = controller
                                    .appointmentsSlot?[controller.slotIndex]
                                    .slots[index]
                                    .available ??
                                false;
                            var date = DateTime.parse(controller
                                    .appointmentsSlot?[controller.slotIndex]
                                    .slots[index]
                                    .startTime ??
                                "");

                            String formattedTime = DateFormat.Hm().format(date);

                            return Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: OutlinedButton(
                                style: availableDate == true
                                    ? ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          TestColor().primaryColor,
                                        ),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                      )
                                    : ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          Colors.grey[500],
                                        ),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0))),
                                      ),
                                onPressed: () {},
                                child: Text(
                                  formattedTime,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }),
                    ),
            );
          },
        ),

        //appointment button pressed
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  TestColor().primaryColor,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {},
              child: const Text(
                "Appointment",
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
