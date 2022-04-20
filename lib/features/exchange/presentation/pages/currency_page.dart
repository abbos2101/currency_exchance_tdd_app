import 'package:currency_exchance_tdd_app/core/network/api.dart';
import 'package:currency_exchance_tdd_app/di.dart';
import 'package:currency_exchance_tdd_app/widgets/custom_safe_area.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/currency/currency_bloc.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({Key? key}) : super(key: key);

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  final CurrencyBloc bloc = di<CurrencyBloc>();

  @override
  void initState() {
    bloc.add(const GetCurrenciesLastEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<CurrencyBloc, CurrencyState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is EmptyState) {
              return const Center(
                child: Text(
                  "Ma'lumot topilmadi :(",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }
            if (state is SuccessState) {
              return ListView.separated(
                itemCount: state.currencies.length,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                separatorBuilder: (_, i) => const Divider(),
                itemBuilder: (context, i) {
                  final model = state.currencies[i];
                  return Text(
                    "${i + 1}\n"
                    "Name: ${model.nameUZ}"
                    "Rate: ${model.rate}",
                  );
                },
              );
            }
            if (state is FailState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }
            throw Exception("$state is not found");
          },
        ),
      ),
    );
  }
}
