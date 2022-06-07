// To parse this JSON data, do
//
//     final totalPrice = totalPriceFromJson(jsonString);

import 'dart:convert';

TotalPrice totalPriceFromJson(String str) =>
    TotalPrice.fromJson(json.decode(str));

String totalPriceToJson(TotalPrice data) => json.encode(data.toJson());

class TotalPrice {
  TotalPrice({
    required this.prices,
    required this.currentTime,
  });

  Prices prices;
  String currentTime;

  factory TotalPrice.fromJson(Map<String, dynamic> json) => TotalPrice(
        prices: Prices.fromJson(json["prices"]),
        currentTime: json["current_time"],
      );

  Map<String, dynamic> toJson() => {
        "prices": prices.toJson(),
        "current_time": currentTime,
      };
}

class Prices {
  Prices({
    required this.ounce,
    required this.gram,
    required this.hundredGram,
    required this.thousandGram,
  });

  Gram ounce;
  Gram gram;
  Gram hundredGram;
  Gram thousandGram;

  factory Prices.fromJson(Map<String, dynamic> json) => Prices(
        ounce: Gram.fromJson(json["ounce"]),
        gram: Gram.fromJson(json["gram"]),
        hundredGram: Gram.fromJson(json["hundred_gram"]),
        thousandGram: Gram.fromJson(json["thousand_gram"]),
      );

  Map<String, dynamic> toJson() => {
        "ounce": ounce.toJson(),
        "gram": gram.toJson(),
        "hundred_gram": hundredGram.toJson(),
        "thousand_gram": thousandGram.toJson(),
      };
}

class Gram {
  Gram({
    required this.silver,
    required this.gold,
    required this.platinum,
  });

  double silver;
  double gold;
  double platinum;

  factory Gram.fromJson(Map<String, dynamic> json) => Gram(
        silver: json["silver"].toDouble(),
        gold: json["gold"].toDouble(),
        platinum: json["platinum"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "silver": silver,
        "gold": gold,
        "platinum": platinum,
      };
}
