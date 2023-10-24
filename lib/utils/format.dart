
String? formatDate(DateTime? date) {
  if (date != null) {
    return "${date.month}-${date.day}-${date.year}";
  }
  return "---";
}
