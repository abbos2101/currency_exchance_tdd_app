import 'package:currency_exchance_tdd_app/core/network/api.dart';
import 'package:currency_exchance_tdd_app/core/network/network_info.dart';
import 'package:currency_exchance_tdd_app/features/exchange/data/repositories/currency_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/exchange/data/data_sources/currency/currency_local_data_source.dart';
import 'features/exchange/data/data_sources/currency/currency_remote_data_source.dart';
import 'features/exchange/domain/repositories/currency_repository.dart';
import 'features/exchange/presentation/bloc/currency/currency_bloc.dart';
import 'features/exchange/domain/use_cases/currency/get_currencies_by_date.dart';
import 'features/exchange/domain/use_cases/currency/get_currencies_last.dart';

final GetIt di = GetIt.instance;

Future<void> init() async {
  // Core
  final pref = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => pref);
  //di.registerLazySingleton(() => DataConnectionChecker());
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  di.registerLazySingleton(() => Api());

  ///Feature [Exchange]
  // Bloc
  di.registerFactory(() => CurrencyBloc(
        currenciesByDate: di<GetCurrenciesByDate>(),
        currenciesLast: di<GetCurrenciesLast>(),
      ));
  // Use cases
  di.registerLazySingleton(() => GetCurrenciesByDate(di<CurrencyRepository>()));
  di.registerLazySingleton(() => GetCurrenciesLast(di<CurrencyRepository>()));
  // Repository
  di.registerLazySingleton<CurrencyRepository>(() => CurrencyRepositoryImpl(
        localDataSource: di<CurrencyLocalDataSource>(),
        remoteDataSource: di<CurrencyRemoteDataSource>(),
        networkInfo: di<NetworkInfo>(),
      ));
  // Data sources
  di.registerLazySingleton<CurrencyLocalDataSource>(
    () => CurrencyLocalDataSourceImpl(pref: di<SharedPreferences>()),
  );
  di.registerLazySingleton<CurrencyRemoteDataSource>(
    () => CurrencyRemoteDataSourceImpl(dio: di<Api>().dio),
  );

  ///Feature [Exchange]
  ///Feature [Name]
  // Blocs
  // body
  // Use Cases
  // body
  // Repositories
  // body
  // Data Sources
  // body
  ///Feature [Name]
}
