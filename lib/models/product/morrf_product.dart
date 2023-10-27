import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morrf/models/product/morrf_product_package.dart';
import 'package:uuid/uuid.dart';

import 'morrf_faq.dart';
import 'morrf_rating.dart';

class MorrfProduct {
  final String id,
      trainerId,
      title,
      heroUrl,
      productCategoryName,
      description,
      serviceType;
  final List<String> photoUrls;
  final List<MorrfRating> ratings;
  final List<String>? tags;
  final List<MorrfFaq> faq;
  final List<MorrfProductPackage> tiers;

  MorrfProduct(
      {required this.id,
      required this.trainerId,
      required this.title,
      required this.description,
      required this.photoUrls,
      required this.heroUrl,
      required this.productCategoryName,
      required this.ratings,
      required this.serviceType,
      required this.faq,
      required this.tiers,
      this.tags});

  MorrfProduct.fromData(Map<String, dynamic> data)
      : id = data['id'],
        trainerId = data['trainerId'],
        title = data['title'],
        description = data['description'],
        photoUrls = data['photoUrls'],
        heroUrl = data['heroUrl'],
        productCategoryName = data['productCategoryName'],
        ratings = data['ratings'],
        serviceType = data['serviceType'],
        faq = data['faq'],
        tiers = data['tiers'],
        tags = data['tags'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trainerId': trainerId,
      'title': title,
      'description': description,
      'photoUrl': photoUrls,
      'heroUrl': heroUrl,
      'productCategoryName': productCategoryName,
      "ratings": ratings,
      "serviceType": serviceType,
      "faq": faq,
      "tiers": tiers,
      "tags": tags
    };
  }
}
