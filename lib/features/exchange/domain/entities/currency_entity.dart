import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final int id;
  final String code;
  final String name;
  final String rate;
  final String diff;
  final String date;

  const CurrencyEntity({
    required this.id,
    required this.code,
    required this.name,
    required this.rate,
    required this.diff,
    required this.date,
  });

  @override
  List<Object?> get props => [id, code, name, rate, diff, date];
}
