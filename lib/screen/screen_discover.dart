import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:take_home_app/res/controller/discover_controller.dart';
import 'package:take_home_app/res/controller/login_controller.dart';
import 'package:take_home_app/res/value.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await Get.dialog(
            AlertDialog(
              title: Text(
                'Are you sure?',
                style: Theme.of(context).textTheme.headline5,
              ),
              content: const Text(
                'Do you really want to exit?',
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(canPop: true, closeOverlays: false),
                  child: Text(
                    'Stay',
                    style: TextStyle(color: TestColor().primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    SystemNavigator.pop();
                  },
                  child: Text(
                    'Leave',
                    style: TextStyle(color: TestColor().primaryColor),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: () async {
        return showExitPopup();
      },
      child: const Scaffold(
        primary: true,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SafeArea(
            child: CarouselScreen(),
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          //Add Text for Banner
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 10),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Banner Home",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                )),
          ),
          //Carousel Slider for different price
          GetBuilder<DiscoverController>(builder: (controller) {
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
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (priceKey.toString().toUpperCase() ==
                                      "SILVER")
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 20,
                                          color: TestColor().silverColor,
                                        ),
                                        Text(priceKey.toString().toUpperCase()),
                                      ],
                                    ),
                                  if (priceKey.toString().toUpperCase() ==
                                      "GOLD")
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 20,
                                          color: TestColor().goldColor,
                                        ),
                                        Text(priceKey.toString().toUpperCase()),
                                      ],
                                    ),
                                  if (priceKey.toString().toUpperCase() ==
                                      "PLATINUM")
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          size: 20,
                                          color: TestColor().platinumColor,
                                        ),
                                        Text(priceKey.toString().toUpperCase()),
                                      ],
                                    ),
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
          const Divider(
            height: 1,
          ),
          //Show appointment each date time
          const AppointmentScreen(),
        ],
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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(width: 0.5, color: Colors.grey)),
            child: SizedBox(
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
          ),
        ),
        //Display available and unavailable color
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: TestColor().secondaryColor,
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
                  const Text("Unavailable"),
                ],
              )
            ],
          ),
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
                  ? const Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 8),
                      child: SizedBox(
                        height: 30,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Data isn't available"),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                      child: SizedBox(
                        height: 150,
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller
                                    .appointmentsSlot?[controller.slotIndex]
                                    .slots
                                    .length ??
                                0,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 5,
                              childAspectRatio: 3,
                            ),
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

                              String formattedTime =
                                  DateFormat.Hm().format(date);

                              return Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: OutlinedButton(
                                  style: availableDate == true
                                      ? ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                            TestColor().secondaryColor,
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
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
            );
          },
        ),

        //appointment button pressed
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Container(
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
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Thanks',
                    ),
                    duration: Duration(milliseconds: 500),
                  ));
                },
                child: const Text(
                  "Book Appointment",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  TestColor().platinumColor,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              onPressed: () {
                Get.find<LoginController>().logout();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Logout",
                    style: TextStyle(color: TestColor().primaryColor),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.logout,
                    color: TestColor().primaryColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
