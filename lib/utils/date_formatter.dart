import 'package:intl/intl.dart';

String formatDate(String value) {
  if (value == null || value.isEmpty) return "";
  DateTime date = parseDate(value);
  if ((date?.year ?? 1800) < 1900) return "";
  return formatDateCustom(date, format: 'MM-dd-yy');
}

String formatDateCustom(DateTime value, {String format = "MM-dd-yyyy"}) {
  try {
    if (value == null) return "";
    var _date = DateFormat(format).format(value);
    if (_date.contains("1800")) return "";
    return _date;
  } catch (e) {
    print(e);
    return "";
  }
}

DateTime parseDate(String value) {
  DateTime date;
  try {
    date = DateTime.parse(value);
  } catch (e) {
    return null;
  }
  return date;
}

String epochToDate(int time, {String format = "MM-dd-yyyy"}) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
  String output = DateFormat(format).format(date).toString(); // yMd
  return output;
}
