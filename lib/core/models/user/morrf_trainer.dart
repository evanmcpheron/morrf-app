import 'package:morrf/core/models/morrf_rating.dart';
import 'package:morrf/core/models/morrf_service.dart';
import 'package:morrf/core/models/order/morrf_order.dart';

class MorrfTrainer {
  final String id;
  final List<MorrfService> services;
  final List<MorrfRating> ratings;
  final List<MorrfOrder> orders;

  MorrfTrainer(
      {required this.id,
      required this.services,
      required this.ratings,
      required this.orders});

  MorrfTrainer.fromData(Map<String, dynamic> data)
      : id = data['id'],
        services = List<MorrfService>.from(data['services']),
        orders = List<MorrfOrder>.from(data['orders']),
        ratings = List<MorrfRating>.from(data['ratings']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'services': services,
      'ratings': ratings,
      'orders': orders,
    };
  }
}
