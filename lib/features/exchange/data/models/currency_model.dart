import 'package:currency_exchance_tdd_app/features/exchange/domain/entities/currency_entity.dart';

class CurrencyModel extends CurrencyEntity {
  final int id;
  final String code;
  final String name;
  final String nameUZ;
  final String nameUZC;
  final String nameRU;
  final String nameEN;
  final String rate;
  final String diff;
  final String date;

  const CurrencyModel({
    required this.id,
    required this.code,
    required this.name,
    required this.nameUZ,
    required this.nameUZC,
    required this.nameRU,
    required this.nameEN,
    required this.rate,
    required this.diff,
    required this.date,
  }) : super(
          id: id,
          code: code,
          name: name,
          rate: rate,
          diff: diff,
          date: date,
        );

  factory CurrencyModel.fromJson(
    Map<String, dynamic> json, {
    required String lang,
  }) {
    String name = "";
    switch (name) {
      case "UZ":
        name = json["CcyNm_UZ"] ?? "";
        break;
      case "UZC":
        name = json["CcyNm_UZC"] ?? "";
        break;
      case "RU":
        name = json["CcyNm_RU"] ?? "";
        break;
      case "EN":
        name = json["CcyNm_EN"] ?? "";
        break;
    }
    return CurrencyModel(
      id: json["id"] ?? -1,
      code: json["Ccy"] ?? "",
      name: name,
      nameUZ: json["CcyNm_UZ"] ?? "",
      nameUZC: json["CcyNm_UZC"] ?? "",
      nameRU: json["CcyNm_RU"] ?? "",
      nameEN: json["CcyNm_EN"] ?? "",
      rate: json["Rate"] ?? "",
      diff: json["Diff"] ?? "",
      date: json["Date"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "name": name,
      "nameUZ": nameUZ,
      "nameUZC": nameUZC,
      "nameRU": nameRU,
      "nameEN": nameEN,
      "rate": rate,
      "diff": diff,
      "date": date,
    };
  }
}
