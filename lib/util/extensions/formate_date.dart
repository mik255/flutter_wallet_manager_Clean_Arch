import 'package:intl/intl.dart';

extension FormateDate on DateTime {
  String toBrazilianDate() {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(this);
  }

  String toHour() {
    final formatter = DateFormat('HH:mm');
    return formatter.format(this);
  }

  String formatDate({bool onlyDate = false}) {
    final now = DateTime.now();
    final yesterday = now.subtract(Duration(days: 1));

    if (year == now.year && month == now.month && day == now.day&& !onlyDate) {
      return 'Hoje';
    } else if (year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day&& !onlyDate) {
      return 'Ontem';
    } else {
      final monthNames = [
        '',
        'JAN',
        'FEV',
        'MAR',
        'ABR',
        'MAI',
        'JUN',
        'JUL',
        'AGO',
        'SET',
        'OUT',
        'NOV',
        'DEZ'
      ];

      return '${day.toString().padLeft(2, '0')} ${monthNames[month]}';
    }
  }
}
