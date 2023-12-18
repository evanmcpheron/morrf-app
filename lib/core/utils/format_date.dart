import 'package:morrf/models/morrf_service.dart';
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

double getLowestPrice(Map<String, Tier> tier) {
  if (tier['basic']!.isVisible) {
    return formatPrice(tier['basic']!.price);
  } else if (tier['standard']!.isVisible) {
    return formatPrice(tier['standard']!.price);
  } else if (tier['premium']!.isVisible) {
    return formatPrice(tier['premium']!.price);
  }
  return formatPrice(0);
}

int getTabLength(Map<String, Tier> tiers) {
  int tabCount = 0;
  if (tiers['basic']!.isVisible) {
    tabCount++;
  }
  if (tiers['standard']!.isVisible) {
    tabCount++;
  }
  if (tiers['premium']!.isVisible) {
    tabCount++;
  }
  return tabCount;
}

double formatPrice(double? price) {
  return price != null
      ? price.toStringAsFixed(2).toDouble()
      : 0.toStringAsFixed(0).toDouble();
}
