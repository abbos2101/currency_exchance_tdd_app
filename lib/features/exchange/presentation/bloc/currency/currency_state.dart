part of 'currency_bloc.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();
}

class LoadingState extends CurrencyState {
  @override
  List<Object> get props => [];
}

class SuccessState extends CurrencyState {
  final List<CurrencyEntity> currencies;
  final int index;
  final DateTime date;

  const SuccessState({
    required this.currencies,
    required this.index,
    required this.date,
  });

  @override
  List<Object> get props => [currencies, index, date];
}

class FailState extends CurrencyState {
  final String message;

  const FailState(this.message);

  @override
  List<Object> get props => [message];
}

class EmptyState extends CurrencyState {
  @override
  List<Object> get props => [];
}
