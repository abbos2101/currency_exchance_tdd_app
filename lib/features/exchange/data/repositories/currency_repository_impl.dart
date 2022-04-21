import 'package:currency_exchance_tdd_app/core/error/exceptions.dart';
import 'package:currency_exchance_tdd_app/core/error/failures.dart';
import 'package:currency_exchance_tdd_app/core/network/network_info.dart';
import 'package:currency_exchance_tdd_app/features/exchange/data/data_sources/currency/currency_local_data_source.dart';
import 'package:currency_exchance_tdd_app/features/exchange/data/data_sources/currency/currency_remote_data_source.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/entities/currency_entity.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyLocalDataSource localDataSource;
  final CurrencyRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const CurrencyRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrenciesByDate(
    DateTime date,
  ) async {
    if (await networkInfo.isConnected) {
      if (DateTime.now().difference(date).inHours > 20) {
        try {
          final currencies = await localDataSource.getCurrenciesByDate(date);
          return Right(currencies);
        } catch (_) {}
      }
      try {
        final currencies = await remoteDataSource.getCurrenciesByDate(date);
        await localDataSource.saveCurrenciesByDate(currencies, date);
        return Right(currencies);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSource.getCurrenciesByDate(date));
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrenciesLast() async {
    if (await networkInfo.isConnected) {
      try {
        final currencies = await remoteDataSource.getCurrenciesLast();
        await localDataSource.saveCurrenciesByDate(currencies, DateTime.now());
        return Right(currencies);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      try {
        final currencies = await localDataSource.getCurrenciesByDate(
          DateTime.now(),
        );
        return Right(currencies);
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }
}
