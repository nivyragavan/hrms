// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  List<Datum>? data;

  CountryModel({
    this.data,
  });

  CountryModel copyWith({
    List<Datum>? data,
  }) =>
      CountryModel(
        data: data ?? this.data,
      );

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  int? id;
  String? name;
  String? iso3;
  String? iso2;
  String? phoneCode;
  String? capital;
  String? currency;
  String? native;
  String? emoji;
  String? emojiU;
  DateTime? createdAt;

  Datum({
    this.id,
    this.name,
    this.iso3,
    this.iso2,
    this.phoneCode,
    this.capital,
    this.currency,
    this.native,
    this.emoji,
    this.emojiU,
    this.createdAt,
  });

  Datum copyWith({
    int? id,
    String? name,
    String? iso3,
    String? iso2,
    String? phoneCode,
    String? capital,
    String? currency,
    String? native,
    String? emoji,
    String? emojiU,
    DateTime? createdAt,
  }) =>
      Datum(
        id: id ?? this.id,
        name: name ?? this.name,
        iso3: iso3 ?? this.iso3,
        iso2: iso2 ?? this.iso2,
        phoneCode: phoneCode ?? this.phoneCode,
        capital: capital ?? this.capital,
        currency: currency ?? this.currency,
        native: native ?? this.native,
        emoji: emoji ?? this.emoji,
        emojiU: emojiU ?? this.emojiU,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        iso3: json["iso3"],
        iso2: json["iso2"],
        phoneCode: json["phone_code"],
        capital: json["capital"],
        currency: json["currency"],
        native: json["native"],
        emoji: json["emoji"],
        emojiU: json["emojiU"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "iso3": iso3,
        "iso2": iso2,
        "phone_code": phoneCode,
        "capital": capital,
        "currency": currency,
        "native": native,
        "emoji": emoji,
        "emojiU": emojiU,
        "created_at": createdAt?.toIso8601String(),
      };
}
