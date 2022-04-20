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

  const SuccessState(this.currencies);

  @override
  List<Object> get props => [currencies];
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
