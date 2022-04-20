import 'package:currency_exchance_tdd_app/features/exchange/domain/entities/currency_entity.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

class CalculateDialog extends StatefulWidget {
  final CurrencyEntity model;

  const CalculateDialog._(this.model, {Key? key}) : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required CurrencyEntity model,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CalculateDialog._(model),
    );
  }

  @override
  State<CalculateDialog> createState() => _CalculateDialogState();
}

class _CalculateDialogState extends State<CalculateDialog> {
  late final rate = double.parse(widget.model.rate);
  double first = 1;
  late double second = rate;
  final firstController = TextEditingController(text: "1");
  late final secondController = TextEditingController(
    text: MoneyFormatter(amount: second).output.nonSymbol + " so'm",
  );
  bool changed = false;

  @override
  void initState() {
    firstController.addListener(() {
      if (firstController.text.isNotEmpty) {
        if (changed) {
          first = double.parse(
            firstController.text.replaceAll(",", "").replaceAll(" so'm", ""),
          );
          second = first / rate;
          secondController.text =
              MoneyFormatter(amount: second).output.nonSymbol;
        } else {
          first = double.parse(
            firstController.text.replaceAll(",", "").replaceAll(" so'm", ""),
          );
          second = first * rate;
          secondController.text =
              MoneyFormatter(amount: second).output.nonSymbol + " so'm";
        }
      } else {
        first = 0;
        second = 0;
        secondController.text = changed ? "0" : "0 so'm";
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    firstController.dispose();
    secondController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.model.nameUZ;
    if (context.locale == const Locale("uz", "UZC")) {
      name = widget.model.nameUZC;
    } else if (context.locale == const Locale("ru", "RU")) {
      name = widget.model.nameRU;
    } else if (context.locale == const Locale("en", "EN")) {
      name = widget.model.nameEN;
    }
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(
        bottom: bottom == 0 ? 40 : bottom + 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 50,
            height: 10,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: firstController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              CurrencyTextInputFormatter(symbol: "", decimalDigits: 0),
            ],
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: const OutlineInputBorder(),
              label: Text(changed ? "UZS" : widget.model.code),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: secondController,
            readOnly: true,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              border: const OutlineInputBorder(),
              label: Text(changed ? widget.model.code : "UZS"),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                setState(() => changed = !changed);
                firstController.text =
                    MoneyFormatter(amount: second).output.withoutFractionDigits;
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  CupertinoIcons.arrow_up_arrow_down,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
