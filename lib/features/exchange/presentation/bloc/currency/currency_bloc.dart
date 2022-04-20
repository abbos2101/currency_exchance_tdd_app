import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
  }) : super(Loading()) {
    on<CurrencyEvent>(
      (event, emit) async {
        // TODO: implement event handler
      },
      transformer: sequential(),
    );
  }
}
