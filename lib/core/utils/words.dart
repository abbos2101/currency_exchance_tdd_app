import 'package:easy_localization/src/public_ext.dart';

extension MyWords on Words {
  String tr([int? index]) {
    return "$name${index ?? ""}".tr();
  }
}

enum Words {
  calculate,
  langUZ,
  langUZC,
  langRU,
  langEN,
  name,
  notFound,
  hasError,
  refresh,
}
