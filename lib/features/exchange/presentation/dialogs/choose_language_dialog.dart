import 'package:currency_exchance_tdd_app/core/utils/words.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseLanguageDialog extends StatelessWidget {
  const ChooseLanguageDialog._({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const ChooseLanguageDialog._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _LanguageItem(
            checked: context.locale == const Locale("uz", "UZ"),
            text: Words.langUZ.tr(),
            onTap: () => onTap(context, const Locale("uz", "UZ")),
          ),
          const Divider(thickness: 0.8),
          _LanguageItem(
            checked: context.locale == const Locale("uz", "UZC"),
            text: Words.langUZC.tr(),
            onTap: () => onTap(context, const Locale("uz", "UZC")),
          ),
          const Divider(thickness: 0.8),
          _LanguageItem(
            checked: context.locale == const Locale("ru", "RU"),
            text: Words.langRU.tr(),
            onTap: () => onTap(context, const Locale("ru", "RU")),
          ),
          const Divider(thickness: 0.8),
          _LanguageItem(
            checked: context.locale == const Locale("en", "EN"),
            text: Words.langEN.tr(),
            onTap: () => onTap(context, const Locale("en", "EN")),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  void onTap(BuildContext context, Locale locale) {
    context.setLocale(locale);
    //Navigator.pop(context);
  }
}

class _LanguageItem extends StatelessWidget {
  final bool checked;
  final String text;
  final Function()? onTap;

  const _LanguageItem({
    Key? key,
    required this.checked,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(
            checked ? CupertinoIcons.check_mark_circled : CupertinoIcons.circle,
            size: 24,
            color: checked ? Theme.of(context).primaryColor : Colors.black,
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            text,
            style: TextStyle(
              color: checked ? Theme.of(context).primaryColor : Colors.black,
              fontSize: 16,
            ),
          )),
        ],
      ),
    );
  }
}
