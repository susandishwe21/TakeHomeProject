// To parse this JSON data, do
//
//     final appointmentsSlot = appointmentsSlotFromJson(jsonString);

import 'dart:convert';

List<AppointmentsSlot> appointmentsSlotFromJson(String str) =>
    List<AppointmentsSlot>.from(
        json.decode(str).map((x) => AppointmentsSlot.fromJson(x)));

String appointmentsSlotToJson(List<AppointmentsSlot> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppointmentsSlot {
  AppointmentsSlot({
    required this.date,
    required this.slots,
  });

  DateTime date;
  List<Slot> slots;

  factory AppointmentsSlot.fromJson(Map<String, dynamic> json) =>
      AppointmentsSlot(
        date: DateTime.parse(json["date"]),
        slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
      };
}

class Slot {
  Slot({
    required this.startTime,
    required this.endTime,
    required this.available,
  });

  String startTime;
  String endTime;
  bool available;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        startTime: json["start_time"],
        endTime: json["end_time"],
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "start_time": startTime,
        "end_time": endTime,
        "available": available,
      };
}
