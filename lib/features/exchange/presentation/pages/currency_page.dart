import 'package:currency_exchance_tdd_app/core/utils/words.dart';
import 'package:currency_exchance_tdd_app/di.dart';
import 'package:currency_exchance_tdd_app/features/exchange/presentation/dialogs/choose_language_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/currency/currency_bloc.dart';
import '../dialogs/calculate_dialog.dart';
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
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
          ),
          centerTitle: false,
          title: Text(Words.name.tr()),
          actions: [
            BlocBuilder<CurrencyBloc, CurrencyState>(
              builder: (context, state) {
                var initialDate = DateTime.now();
                if (state is SuccessState) {
                  initialDate = state.date;
                }
                return GestureDetector(
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: initialDate,
                      firstDate: DateTime.now().subtract(
                        const Duration(days: 180),
                      ),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      bloc.add(OnChangeDateEvent(date: date));
                      bloc.add(GetCurrenciesByDateEvent(date: date));
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: const Icon(CupertinoIcons.calendar),
                );
              },
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () => ChooseLanguageDialog.show(context),
              behavior: HitTestBehavior.opaque,
              child: const Icon(Icons.language),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: BlocBuilder<CurrencyBloc, CurrencyState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CupertinoActivityIndicator());
            }
            if (state is EmptyState) {
              return Center(
                child: Text(
                  Words.notFound.tr(),
                  style: const TextStyle(fontSize: 18),
                ),
              );
            }
            if (state is SuccessState) {
              return RefreshIndicator(
                onRefresh: () async => bloc.add(const RefreshEvent()),
                color: Theme.of(context).primaryColor,
                child: ListView.builder(
                  itemCount: state.currencies.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return CurrencyCardItem(
                      model: state.currencies[i],
                      open: i == state.index,
                      onTap: () => bloc.add(OnTapItemEvent(index: i)),
                      onTapCalculate: () {
                        CalculateDialog.show(context,
                            model: state.currencies[i]);
                      },
                    );
                  },
                ),
              );
            }
            if (state is FailState) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Words.hasError.tr(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => bloc.add(const RefreshEvent()),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          Words.refresh.tr(),
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
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
