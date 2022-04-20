import 'package:equatable/equatable.dart';

class CurrencyEntity extends Equatable {
  final int id;
  final String code;
  final String nameUZ;
  final String nameUZC;
  final String nameRU;
  final String nameEN;
  final String rate;
  final String diff;
  final String date;

  const CurrencyEntity({
    required this.id,
    required this.code,
    required this.nameUZ,
    required this.nameUZC,
    required this.nameRU,
    required this.nameEN,
    required this.rate,
    required this.diff,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        code,
        nameUZ,
        nameUZC,
        nameRU,
        nameEN,
        rate,
        diff,
        date,
      ];
}
