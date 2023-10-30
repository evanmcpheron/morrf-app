import 'package:get/get.dart';
import 'package:morrf/models/service/morrf_service.dart';
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

double getLowestPrice(Map<String, dynamic> tier) {
  if (tier['basic']['isVisible']) {
    return formatPrice(tier['basic']['price']);
  } else if (tier['standard']['isVisible']) {
    return formatPrice(tier['standard']['price']);
  } else if (tier['premium']['isVisible']) {
    return formatPrice(tier['premium']['price']);
  }
  return formatPrice(0);
}

double formatPrice(double price) {
  return price.toStringAsFixed(2).toDouble();
}
