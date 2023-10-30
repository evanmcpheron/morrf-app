import 'package:morrf/models/service/morrf_service.dart';

String? formatDate(DateTime? date) {
  if (date != null) {
    return "${date.month}-${date.day}-${date.year}";
  }
  return "---";
}

String capitalize(String string) {
  return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
}

int getLowestPrice(Map<String, Tier> tier) {
  return 0;
}
