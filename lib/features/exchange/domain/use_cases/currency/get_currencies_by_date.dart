import 'package:currency_exchance_tdd_app/core/error/failures.dart';
import 'package:currency_exchance_tdd_app/core/usecases/usecase.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/entities/currency_entity.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetCurrenciesByDate implements UseCase<List<CurrencyEntity>, Params> {
  final CurrencyRepository repository;

  GetCurrenciesByDate(this.repository);

  @override
  Future<Either<Failure, List<CurrencyEntity>>> call(Params params) async {
    return await repository.getCurrenciesByDate(params.date, lang: params.lang);
  }
}

class Params extends Equatable {
  final DateTime date;
  final String lang;

  const Params({required this.date, required this.lang});

  @override
  List<Object?> get props => [date, lang];
}
