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

class RefreshEvent extends CurrencyEvent {
  const RefreshEvent();

  @override
  List<Object?> get props => [];
}

class OnTapItemEvent extends CurrencyEvent {
  final int index;

  const OnTapItemEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class OnChangeDateEvent extends CurrencyEvent {
  final DateTime date;

  const OnChangeDateEvent({required this.date});

  @override
  List<Object?> get props => [date];
}
