import 'package:intl/intl.dart';

formatCurrency(value) {
  if (value != null) {
    final formatCurrency = new NumberFormat.currency(
        locale: 'en_US', symbol: '', decimalDigits: 2);
    return formatCurrency.format(value);
  }
  return 0;
}

formatDate(value) {
  if (value != null) {
    var txndate = DateTime.fromMillisecondsSinceEpoch(value);
    final txnDateFmt = DateFormat('dd-MM-yyyy').format(txndate);
    return txnDateFmt;
  }
  return DateFormat('dd-MM-yyyy').format(DateTime.now());
}

formatStringToDate(string) {
  return new DateFormat('MM d, yyyy')
      .format(string != null ? DateTime.parse(string) : new DateTime.now());
}
