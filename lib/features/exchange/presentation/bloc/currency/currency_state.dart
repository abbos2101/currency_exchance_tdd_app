part of 'currency_bloc.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();
}

class Loading extends CurrencyState {
  @override
  List<Object> get props => [];
}

class Success extends CurrencyState {
  final List<CurrencyEntity> currencies;

  const Success(this.currencies);

  @override
  List<Object> get props => [currencies];
}

class Fail extends CurrencyState {
  final String message;

  const Fail(this.message);

  @override
  List<Object> get props => [message];
}

class Empty extends CurrencyState {
  @override
  List<Object> get props => [];
}
