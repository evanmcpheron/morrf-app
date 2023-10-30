import 'package:firebase_auth/firebase_auth.dart';
import 'package:morrf/widgets/data.dart';

import 'morrf_faq.dart';
import 'morrf_rating.dart';

class TitleModel {
  String title;
  bool isSelected;

  TitleModel(this.title, this.isSelected);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "isSelected": isSelected,
    };
  }
}

class Tier {
  List<TitleModel?> options;
  double? price;
  int deliveryTime;
  bool isVisible;

  Tier(
      {required this.options,
      this.price,
      required this.deliveryTime,
      required this.isVisible});

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> optionsList = [];
    for (TitleModel? option in options) {
      optionsList.add(option!.toJson());
    }
    return {
      "options": optionsList,
      "price": price,
      "deliveryTime": deliveryTime,
      "isVisible": isVisible
    };
  }
}

class MorrfProduct {
  final String id,
      trainerId,
      title,
      heroUrl,
      category,
      subcategory,
      description,
      serviceType;
  final List<String> photoUrls;
  final List<MorrfRating> ratings;
  final List<String>? tags;
  final List<MorrfFaq> faq;
  final Map<String, Tier> tiers;

  MorrfProduct({
    required this.id,
    required this.trainerId,
    required this.title,
    required this.category,
    required this.subcategory,
    required this.serviceType,
    required this.description,
    this.tags,
    required this.faq,
    required this.tiers,
    required this.photoUrls,
    required this.heroUrl,
    required this.ratings,
  });

  MorrfProduct.fromPartialData(Map<String, dynamic> data, MorrfProduct product)
      : id = data['id'] ?? product.id,
        trainerId = data['trainerId'] ?? product.trainerId,
        title = data['title'] ?? product.title,
        description = data['description'] ?? product.description,
        subcategory = data['subcategory'] ?? product.subcategory,
        photoUrls = data['photoUrls'] ?? product.photoUrls,
        heroUrl = data['heroUrl'] ?? product.heroUrl,
        category = data['category'] ?? product.category,
        ratings = data['ratings'] ?? product.ratings,
        serviceType = data['serviceType'] ?? product.serviceType,
        faq = data['faq'] != null ? data['faq'].cast<MorrfFaq>() : product.faq,
        tiers = data['tiers'] != null
            ? data['tiers'].cast<String>()
            : product.tiers,
        tags =
            data['tags'] != null ? data['tags'].cast<String>() : product.tags;

  MorrfProduct.fromData(Map<String, dynamic> data)
      : id = data['id'],
        trainerId = data['trainerId'],
        title = data['title'],
        description = data['description'],
        subcategory = data['subcategory'],
        photoUrls = data['photoUrls'].cast<String>(),
        heroUrl = data['heroUrl'],
        category = data['category'],
        ratings = data['ratings'].cast<MorrfRating>(),
        serviceType = data['serviceType'],
        faq = data['faq'].cast<MorrfFaq>(),
        tiers = data['tiers'].cast<String, Tier>(),
        tags = data['tags'] != null ? data['tags'].cast<String>() : [];

  MorrfProduct.fromTierData(Map<String, Tier> data, MorrfProduct product)
      : id = product.id,
        trainerId = product.trainerId,
        title = product.title,
        description = product.description,
        subcategory = product.subcategory,
        photoUrls = product.photoUrls,
        heroUrl = product.heroUrl,
        category = product.category,
        ratings = product.ratings,
        serviceType = product.serviceType,
        faq = product.faq,
        tiers = data,
        tags = product.tags;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trainerId': trainerId,
      'title': title,
      'description': description,
      'subcategory': subcategory,
      'photoUrls': photoUrls,
      'heroUrl': heroUrl,
      'category': category,
      "ratings": getRatingJson(ratings),
      "serviceType": serviceType,
      "faq": getFaqJson(faq),
      "tiers": {
        'basic': tiers['basic']!.toJson(),
        'standard': tiers['standard']!.toJson(),
        'premium': tiers['premium']!.toJson(),
      },
      "tags": tags,
    };
  }

  List<Map<String, dynamic>> getFaqJson(List<MorrfFaq> data) {
    List<Map<String, dynamic>> list = [];
    for (var i in data) {
      list.add(i.toJson());
    }
    return list;
  }

  List<Map<String, dynamic>> getRatingJson(List<MorrfRating> data) {
    List<Map<String, dynamic>> list = [];
    for (var i in data) {
      list.add(i.toJson());
    }
    return list;
  }
}
