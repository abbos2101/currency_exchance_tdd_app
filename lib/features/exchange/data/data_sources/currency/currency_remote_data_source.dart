import 'package:currency_exchance_tdd_app/core/error/exceptions.dart';
import 'package:currency_exchance_tdd_app/features/exchange/data/models/currency_model.dart';
import 'package:dio/dio.dart';

abstract class CurrencyRemoteDataSource {
  Future<List<CurrencyModel>> getCurrenciesByDate(
    DateTime date, {
    required String lang,
  });

  Future<List<CurrencyModel>> getCurrenciesLast({required String lang});
}

class CurrencyRemoteDataSourceImpl implements CurrencyRemoteDataSource {
  final Dio dio;

  const CurrencyRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<CurrencyModel>> getCurrenciesByDate(
    DateTime date, {
    required String lang,
  }) async {
    return await _getCurrencies(
      "json/all/${date.year}-${date.month}-${date.day}/",
      lang: lang,
    );
  }

  @override
  Future<List<CurrencyModel>> getCurrenciesLast({required String lang}) async {
    return await _getCurrencies("json/", lang: lang);
  }

  Future<List<CurrencyModel>> _getCurrencies(
    String url, {
    required String lang,
  }) async {
    final response = await dio.get(url);
    if (response.statusCode == 200 && response.data != null) {
      return (response.data as List)
          .map((e) => CurrencyModel.fromJson(e, lang: lang))
          .toList();
    }
    throw ServerException(response);
  }
}
