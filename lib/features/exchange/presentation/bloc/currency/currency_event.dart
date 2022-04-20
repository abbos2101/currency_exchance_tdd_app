part of 'currency_bloc.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();
}

class GetCurrenciesByDateEvent extends CurrencyEvent {
  final DateTime date;

  const GetCurrenciesByDateEvent({required this.date});

  @override
  List<Object?> get props => [date];
}

class GetCurrenciesLastEvent extends CurrencyEvent {
  const GetCurrenciesLastEvent();

  @override
  List<Object?> get props => [];
}
