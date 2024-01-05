import 'package:nb_utils/nb_utils.dart';

String? formatDate(DateTime? date) {
  if (date != null) {
    return "${date.month}-${date.day}-${date.year}";
  }
  return "---";
}

String capitalize(String string) {
  return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
}

double formatPrice(double? price) {
  return price != null
      ? price.toStringAsFixed(2).toDouble()
      : 0.toStringAsFixed(0).toDouble();
}
