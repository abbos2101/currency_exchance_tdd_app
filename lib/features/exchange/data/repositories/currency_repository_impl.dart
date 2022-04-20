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
    DateTime date, {
    required String lang,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getCurrenciesByDate(
          date,
          lang: lang,
        ));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSource.getCurrenciesByDate(
          date,
          lang: lang,
        ));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<CurrencyEntity>>> getCurrenciesLast({
    required String lang,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        return Right(await remoteDataSource.getCurrenciesLast(lang: lang));
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        return Right(await localDataSource.getCurrenciesLast(lang: lang));
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
