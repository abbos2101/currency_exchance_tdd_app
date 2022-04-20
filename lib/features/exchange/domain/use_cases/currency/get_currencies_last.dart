import 'package:currency_exchance_tdd_app/core/error/failures.dart';
import 'package:currency_exchance_tdd_app/core/usecases/usecase.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/entities/currency_entity.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrenciesLast implements UseCase<List<CurrencyEntity>, NoParams> {
  final CurrencyRepository repository;

  GetCurrenciesLast(this.repository);

  @override
  Future<Either<Failure, List<CurrencyEntity>>> execute(NoParams params) async {
    return await repository.getCurrenciesLast();
  }
}