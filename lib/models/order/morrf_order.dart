import 'package:morrf/models/service/morrf_rating.dart';

class MorrfOrder {
  String id;
  String title;
  String serviceId;
  bool paid;
  bool clientLeftReview;
  bool delivered;
  MorrfRating rating;
  bool wasOnTime;

  MorrfOrder({
    required this.id,
    required this.title,
    required this.serviceId,
    required this.paid,
    required this.clientLeftReview,
    required this.delivered,
    required this.rating,
    required this.wasOnTime,
  });

  MorrfOrder.fromData(Map<String, dynamic> data)
      : id = data['id'],
        title = data['title'],
        serviceId = data['serviceId'],
        paid = data['paid'],
        clientLeftReview = data['clientLeftReview'],
        delivered = data['delivered'],
        rating = data['rating'].cast<MorrfRating>(),
        wasOnTime = data['wasOnTime'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'serviceId': serviceId,
      'paid': paid,
      'clientLeftReview': clientLeftReview,
      'delivered': delivered,
      'rating': rating.toJson(),
      'wasOnTime': wasOnTime,
    };
  }
}
