import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:currency_exchance_tdd_app/core/usecases/usecase.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/entities/currency_entity.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/use_cases/currency/get_currencies_by_date.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/use_cases/currency/get_currencies_last.dart';
import 'package:equatable/equatable.dart';

part 'currency_event.dart';

part 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  final GetCurrenciesByDate currenciesByDate;
  final GetCurrenciesLast currenciesLast;

  CurrencyBloc({
    required this.currenciesByDate,
    required this.currenciesLast,
  }) : super(LoadingState()) {
    on<CurrencyEvent>(
      (event, emit) async {
        if (event is GetCurrenciesByDateEvent) {
          await _emitGetCurrenciesByDateEvent(event, emit);
        } else if (event is GetCurrenciesLastEvent) {
          await _emitGetCurrenciesLastEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> _emitGetCurrenciesByDateEvent(
    GetCurrenciesByDateEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(LoadingState());
    final params = Params(date: event.date);
    final result = await currenciesByDate.execute(params);
    result.fold(
      (l) => emit(FailState("$l")),
      (r) => r.isNotEmpty ? emit(SuccessState(r)) : emit(EmptyState()),
    );
  }

  Future<void> _emitGetCurrenciesLastEvent(
    GetCurrenciesLastEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(LoadingState());
    final result = await currenciesLast.execute(NoParams());
    result.fold(
      (l) => emit(FailState("$l")),
      (r) => r.isNotEmpty ? emit(SuccessState(r)) : emit(EmptyState()),
    );
  }
}
