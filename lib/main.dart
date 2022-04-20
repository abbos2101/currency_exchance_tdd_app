import 'package:flutter/material.dart';
import 'di.dart';
import 'package:currency_exchance_tdd_app/features/exchange/presentation/pages/currency_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CurrencyPage(),
    );
  }
}
