import 'package:intl/intl.dart';

extension CurrencyFormatter on num {
  String toCurrencyString({withSymbol = true}) {
    final formatter = NumberFormat.currency(
      symbol: withSymbol ? 'R\$' : '',
      decimalDigits: 2,
      locale: 'pt_BR',
    );
    return formatter.format(this);
  }
}