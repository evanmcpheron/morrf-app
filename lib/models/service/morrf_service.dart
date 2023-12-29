import 'dart:core';

import 'morrf_faq.dart';
import 'morrf_rating.dart';

class Option {
  String title;
  bool isSelected;

  Option(this.title, this.isSelected);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "isSelected": isSelected,
    };
  }

  Option.fromMap(Map<String, dynamic> data)
      : title = data['title'],
        isSelected = data['isSelected'];
}

class Tier {
  List<Option?> options;
  double? price;
  int deliveryTime;
  int revisions;
  String title;

  Tier({
    required this.options,
    required this.title,
    this.price,
    required this.revisions,
    required this.deliveryTime,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> optionsList = [];
    for (Option? option in options) {
      optionsList.add(option!.toJson());
    }
    return {
      "options": optionsList,
      "price": price,
      "title": title,
      "revisions": revisions,
      "deliveryTime": deliveryTime,
    };
  }

  Tier.fromMap(Map<String, dynamic> data)
      : options = (data['options'] as List).map<Option?>((item) {
          return Option.fromMap(item);
        }).toList(),
        price = data['price'],
        revisions = data['revisions'],
        title = data['title'],
        deliveryTime = data['deliveryTime'];
}

class MorrfService {
  final String id,
      trainerName,
      trainerProfileImage,
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
  final List<String> serviceQuestion;
  final Tier tier;

  MorrfService({
    required this.id,
    required this.trainerName,
    required this.trainerProfileImage,
    required this.trainerId,
    required this.title,
    required this.category,
    required this.subcategory,
    required this.serviceType,
    required this.description,
    required this.serviceQuestion,
    required this.faq,
    required this.tier,
    required this.photoUrls,
    required this.heroUrl,
    required this.ratings,
    this.tags,
  });

  MorrfService.fromPartialData(Map<String, dynamic> data, MorrfService service)
      : id = data['id'] ?? service.id,
        trainerName = data['trainerName'] ?? service.trainerName,
        trainerId = data['trainerId'] ?? service.trainerId,
        trainerProfileImage =
            data['trainerProfileImage'] ?? service.trainerProfileImage,
        title = data['title'] ?? service.title,
        description = data['description'] ?? service.description,
        subcategory = data['subcategory'] ?? service.subcategory,
        photoUrls = data['photoUrls'] ?? service.photoUrls,
        heroUrl = data['heroUrl'] ?? service.heroUrl,
        category = data['category'] ?? service.category,
        ratings = data['ratings'] ?? service.ratings,
        serviceType = data['serviceType'] ?? service.serviceType,
        faq = data['faq'] != null ? data['faq'].cast<MorrfFaq>() : service.faq,
        serviceQuestion = data['serviceQuestion'] != null
            ? data['serviceQuestion'].cast<MorrfFaq>()
            : service.serviceQuestion,
        tier = data['tier'] != null ? data['tier'].cast<Tier>() : service.tier,
        tags =
            data['tags'] != null ? data['tags'].cast<String>() : service.tags;

  MorrfService.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        trainerName = data['trainerName'],
        trainerId = data['trainerId'],
        trainerProfileImage = data['trainerProfileImage'],
        title = data['title'],
        description = data['description'],
        subcategory = data['subcategory'],
        photoUrls = data['photoUrls'].cast<String>(),
        heroUrl = data['heroUrl'],
        category = data['category'],
        ratings = data['ratings'].cast<MorrfRating>(),
        serviceType = data['serviceType'],
        faq = data['faq'].cast<MorrfFaq>(),
        serviceQuestion = data['serviceQuestion'].cast<MorrfServiceQuestion>(),
        tier = data['tier'].cast<Tier>(),
        tags = data['tags'] != null ? data['tags'].cast<String>() : [];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trainerName': trainerName,
      'trainerId': trainerId,
      'trainerProfileImage': trainerProfileImage,
      'title': title,
      'description': description,
      'subcategory': subcategory,
      'photoUrls': photoUrls,
      'heroUrl': heroUrl,
      'category': category,
      "ratings": getRatingJson(ratings),
      "serviceType": serviceType,
      "faq": getFaqJson(faq),
      "serviceQuestion": serviceQuestion,
      "tier": tier.toJson(),
      "tags": tags,
    };
  }

  MorrfService.fromTierData(Tier data, MorrfService service)
      : id = service.id,
        trainerName = service.trainerName,
        trainerId = service.trainerId,
        trainerProfileImage = service.trainerProfileImage,
        title = service.title,
        description = service.description,
        subcategory = service.subcategory,
        photoUrls = service.photoUrls,
        heroUrl = service.heroUrl,
        category = service.category,
        ratings = service.ratings,
        serviceType = service.serviceType,
        faq = service.faq,
        serviceQuestion = service.serviceQuestion,
        tier = data,
        tags = service.tags;

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
