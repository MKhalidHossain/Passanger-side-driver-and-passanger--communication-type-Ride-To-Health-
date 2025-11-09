import 'package:intl/intl.dart';

class DateTimeFormatter {
  static String format(String? isoString) {
    if (isoString == null || isoString.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(isoString).toLocal();
      return DateFormat("MMMM dd, hh:mm a").format(dateTime);
    } catch (e) {
      return '';
    }
  }
}
