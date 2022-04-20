import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'di.dart';
import 'package:currency_exchance_tdd_app/features/exchange/presentation/pages/currency_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale("uz", "UZ"),
      Locale("uz", "UZC"),
      Locale("ru", "RU"),
      Locale("en", "EN"),
    ],
    path: 'assets/locals',
    fallbackLocale: const Locale("uz", "UZ"),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
        primaryColor: Colors.deepPurple,
      ),
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      home: const CurrencyPage(),
    );
  }
}
