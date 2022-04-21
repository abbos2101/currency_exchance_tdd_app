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
        } else if (event is RefreshEvent) {
          await _emitRefreshEvent(event, emit);
        } else if (event is OnTapItemEvent) {
          await _emitOnTapItemEvent(event, emit);
        } else if (event is OnChangeDateEvent) {
          await _emitOnChangeDateEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  List<CurrencyEntity> _currencies = [];
  int _index = -1;
  DateTime _date = DateTime.now();

  Future<void> _emitGetCurrenciesByDateEvent(
    GetCurrenciesByDateEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(LoadingState());
    _date = event.date;
    final params = Params(date: _date);
    final result = await currenciesByDate.execute(params);
    result.fold(
      (l) => emit(FailState("$l")),
      (r) {
        _currencies = r;
        if (_currencies.isNotEmpty) {
          emit(SuccessState(
            currencies: _currencies,
            index: _index,
            date: _date,
          ));
        } else {
          emit(EmptyState());
        }
      },
    );
  }

  Future<void> _emitGetCurrenciesLastEvent(
    GetCurrenciesLastEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(LoadingState());
    _date = DateTime.now();
    final result = await currenciesLast.execute(NoParams());
    result.fold(
      (l) => emit(FailState("$l")),
      (r) {
        _currencies = r;
        if (_currencies.isNotEmpty) {
          emit(SuccessState(
            currencies: _currencies,
            index: _index,
            date: _date,
          ));
        } else {
          emit(EmptyState());
        }
      },
    );
  }

  Future<void> _emitRefreshEvent(
    RefreshEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    emit(LoadingState());
    final params = Params(date: _date);
    final result = await currenciesByDate.execute(params);
    result.fold(
      (l) => emit(FailState("$l")),
      (r) {
        _currencies = r;
        if (_currencies.isNotEmpty) {
          emit(SuccessState(
            currencies: _currencies,
            index: _index,
            date: _date,
          ));
        } else {
          emit(EmptyState());
        }
      },
    );
  }

  Future<void> _emitOnTapItemEvent(
    OnTapItemEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    _index = event.index == _index ? -1 : event.index;
    emit(SuccessState(currencies: _currencies, index: _index, date: _date));
  }

  Future<void> _emitOnChangeDateEvent(
    OnChangeDateEvent event,
    Emitter<CurrencyState> emit,
  ) async {
    _date = event.date;
    emit(SuccessState(currencies: _currencies, index: _index, date: _date));
  }
}
