import 'dart:convert';

import 'package:currency_exchance_tdd_app/core/error/exceptions.dart';
import 'package:currency_exchance_tdd_app/features/exchange/data/models/currency_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CurrencyLocalDataSource {
  Future<List<CurrencyModel>> getCurrenciesByDate(DateTime date);

  Future<void> saveCurrenciesByDate(
    List<CurrencyModel> currencies,
    DateTime date,
  );
}

const CURRENCY_BY_DATE = "CURRENCY_BY_DATE";

class CurrencyLocalDataSourceImpl implements CurrencyLocalDataSource {
  final SharedPreferences pref;

  const CurrencyLocalDataSourceImpl({required this.pref});

  @override
  Future<List<CurrencyModel>> getCurrenciesByDate(DateTime date) async {
    final value = pref.getString(
      "$CURRENCY_BY_DATE ${date.year}-${date.month}-${date.day}",
    );
    if (value != null) {
      final data = (jsonDecode(value) as List);
      return data.map((e) => CurrencyModel.fromJson(e)).toList();
    }
    throw CacheException();
  }

  @override
  Future<void> saveCurrenciesByDate(
    List<CurrencyModel> currencies,
    DateTime date,
  ) async {
    final value = jsonEncode(currencies.map((e) => e.toJson()).toList());
    await pref.setString(
      "$CURRENCY_BY_DATE ${date.year}-${date.month}-${date.day}",
      value,
    );
  }
}
