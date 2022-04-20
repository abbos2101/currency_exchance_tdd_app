import 'package:currency_exchance_tdd_app/core/utils/words.dart';
import 'package:currency_exchance_tdd_app/features/exchange/domain/entities/currency_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CurrencyCardItem extends StatelessWidget {
  final CurrencyEntity model;
  final String lang;
  final bool open;
  final Function()? onTap;
  final Function()? onTapCalculate;

  const CurrencyCardItem({
    Key? key,
    required this.model,
    required this.lang,
    required this.open,
    this.onTap,
    this.onTapCalculate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = model.nameUZ;
    if (lang == "UZC") {
      name = model.nameUZC;
    } else if (lang == "RU") {
      name = model.nameRU;
    } else if (lang == "EN") {
      name = model.nameEN;
    }
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(2, 2),
            )
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: name,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: "  "),
                            TextSpan(
                              text:
                                  "${model.diff.contains("-") ? "" : "+"}${model.diff}",
                              style: TextStyle(
                                color: model.diff.contains("-")
                                    ? Colors.redAccent
                                    : Colors.greenAccent,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "1 ${model.code} => ${model.rate} UZS | 📆 ${model.date}",
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                    open ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
              ],
            ),
            SizedBox(height: open ? 8 : 0),
            open
                ? Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: onTapCalculate,
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/calculator.svg",
                                height: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                Words.calculate.tr(),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
