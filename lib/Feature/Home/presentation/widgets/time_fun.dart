import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime startDate) {
    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    final tomorrowStart = todayStart.add(const Duration(days: 1));

    if (startDate.isAfter(todayStart) && startDate.isBefore(tomorrowStart)) {
      return 'Today, At ${DateFormat('HH:mm').format(startDate)}';
    } else {
      return '${DateFormat('yyyy-MM-dd').format(startDate)}, At ${DateFormat('HH:mm').format(startDate)}';
    }
  }
}
