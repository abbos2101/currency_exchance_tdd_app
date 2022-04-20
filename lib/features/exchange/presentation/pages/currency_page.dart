import 'package:currency_exchance_tdd_app/core/utils/words.dart';
import 'package:currency_exchance_tdd_app/di.dart';
import 'package:currency_exchance_tdd_app/features/exchange/presentation/dialogs/choose_language_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency/currency_bloc.dart';
import '../widgets/currency_card_item.dart';

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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
          ),
          centerTitle: false,
          title: Text(Words.name.tr()),
          actions: [
            GestureDetector(
              onTap: () => ChooseLanguageDialog.show(context),
              behavior: HitTestBehavior.opaque,
              child: const Icon(Icons.language),
            ),
            const SizedBox(width: 12),
          ],
        ),
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
              return ListView.builder(
                itemCount: state.currencies.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, i) {
                  return CurrencyCardItem(
                    model: state.currencies[i],
                    lang: context.locale.countryCode ?? "UZ",
                    open: i == state.index,
                    onTap: () => bloc.add(OnTapItemEvent(index: i)),
                    onTapCalculate: () {},
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
