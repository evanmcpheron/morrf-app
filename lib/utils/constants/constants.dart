import 'package:morrf/models/service/morrf_faq.dart';
import 'package:uuid/uuid.dart';

List<String> availableGenders = ["", "Male", "Female"];

List<String> availableCategories = ["Personal Training", "Nutrition"];
List<String> availableSubcategories = ["Something", "else"];
List<String> availableServiceTypes = ["Online", "In Person"];

List<MorrfFaq> globalFaq = [
  MorrfFaq(
      id: const Uuid().v4(),
      question: "Question number on",
      answer: "Answer number 1")
];

enum MorrfSize {
  xs(4.0),
  s(8.0),
  m(16.0),
  l(20.0),
  xl(24.0);

  final double size;
  const MorrfSize(this.size);
}
