import 'package:currency_exchance_tdd_app/core/error/failures.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/entities/currency_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyRepository {
  Future<Either<Failure, List<CurrencyEntity>>> getCurrenciesByDate(
    DateTime date,
  );

  Future<Either<Failure, List<CurrencyEntity>>> getCurrenciesLast();
}
