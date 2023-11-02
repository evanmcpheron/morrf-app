import 'package:morrf/models/service/morrf_rating.dart';
import 'package:morrf/models/service/morrf_service.dart';

class MorrfTrainer {
  final String id;
  final List<MorrfService> services;
  final List<MorrfRating> ratings;

  MorrfTrainer({
    required this.id,
    required this.services,
    required this.ratings,
  });

  MorrfTrainer.fromData(Map<String, dynamic> data)
      : id = data['id'],
        services = List<MorrfService>.from(data['services']),
        ratings = List<MorrfRating>.from(data['ratings']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'services': services,
      'ratings': ratings,
    };
  }
}
