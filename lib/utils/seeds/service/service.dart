import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morrf/models/service/morrf_faq.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/services/firestore/firestore_service.dart';
import 'package:uuid/uuid.dart';
import 'package:faker/faker.dart';

void seedServicesSeed(String trainerId) {
  List<String> categories = ["Personal Trainer", "Nutrition"];
  List<String> suncategories = ["Yoga", "Meal Prep"];
  List<String> serviceTypes = ["Online", "In Person"];
  List<String> photoUrls = [
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/service_images%2F6c175130-044f-4520-9adc-693a430c9249.jpg?alt=media&token=d9170b8b-6bee-4823-aa0d-c693b886074f&_gl=1*kg2hdl*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODYxNDc2Mi43Ny4xLjE2OTg2MjE1OTAuMTIuMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/service_images%2F7220fb6d-caa5-44cf-845b-c3ffccb7ddb7.jpg?alt=media&token=ad6dfb19-87d2-4f6d-a120-e39200b70d62&_gl=1*11f6ejr*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODYxNDc2Mi43Ny4xLjE2OTg2MjE2MjQuNjAuMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/service_images%2Faaea0d69-ad9e-4e03-86b8-b07185b3e76e.jpg?alt=media&token=43ef3a01-109c-4d75-8547-dfc2010fca5c&_gl=1*wm0c1e*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODYxNDc2Mi43Ny4xLjE2OTg2MjE2MzYuNDguMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/service_images%2Fb4b16efb-db38-4ecb-b9f6-3e5d0ea12562.jpg?alt=media&token=6f6276c3-accd-439f-9924-6c0186b79563&_gl=1*giqk21*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODYxNDc2Mi43Ny4xLjE2OTg2MjE2NTEuMzMuMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/service_images%2Fe7f341ea-2608-41ea-815b-50e7712b691e.jpg?alt=media&token=13cc21d2-ff3f-479d-8088-b552bc328ede&_gl=1*ifqk93*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODYxNDc2Mi43Ny4xLjE2OTg2MjE2NjEuMjMuMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/service_images%2Fec28a96f-eca2-4719-b567-7c4b00761c7f.jpg?alt=media&token=c11bf9c4-f128-48df-b2cb-e5c8662b7b7d&_gl=1*1k0u72e*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODYxNDc2Mi43Ny4xLjE2OTg2MjE3MDcuNDguMC4w"
  ];
  photoUrls.shuffle();
  final random = RandomGenerator(seed: 63833423);
  final fakerFa = Faker.withGenerator(random);
  String heroUrl = photoUrls[Random().nextInt(5)];

  String title = fakerFa.lorem.words(Random().nextInt(8) + 2).join(' ');
  String category = categories[Random().nextInt(1)];
  String subcategory = suncategories[Random().nextInt(1)];
  String serviceType = serviceTypes[Random().nextInt(1)];
  String description = fakerFa.lorem.sentences(2).join(' ');
  List<int> deliveryTimes = [3, 5, 7, 12, 15, 20];
  int deliveryTime = deliveryTimes[Random().nextInt(5)];
  bool isVisible = random.boolean();
  List<TitleModel> morrfOptions = [];
  Map<String, Tier> tiers = {
    "basic": Tier(
        options: morrfOptions,
        deliveryTime: deliveryTime,
        isVisible: isVisible),
    "standard": Tier(
        options: morrfOptions,
        deliveryTime: deliveryTime,
        isVisible: isVisible),
    "premium": Tier(
        options: morrfOptions, deliveryTime: deliveryTime, isVisible: isVisible)
  };
  List<String> tags() {
    List<String> tagList = [];
    int random = Random().nextInt(5);
    for (var i = 0; i < random; i++) {
      tagList.add(fakerFa.lorem.word());
    }
    return tagList;
  }

  List<MorrfFaq> morrfFaqs() {
    int faqCount = Random().nextInt(8);
    List<MorrfFaq> faqList = [];

    for (var i = 0; i < faqCount; i++) {
      String question =
          "${fakerFa.lorem.words(Random().nextInt(10)).join(' ')}?";
      String answer = fakerFa.lorem.sentences(2).join(' ');
      faqList
          .add(MorrfFaq(id: Uuid().v4(), question: question, answer: answer));
    }
    return faqList;
  }

  MorrfService morrfService = MorrfService(
      id: Uuid().v4(),
      trainerId: trainerId,
      title: title,
      category: category,
      subcategory: subcategory,
      serviceType: serviceType,
      description: description,
      faq: morrfFaqs(),
      tiers: tiers,
      tags: tags(),
      photoUrls: photoUrls,
      heroUrl: heroUrl,
      ratings: []);
  FirestoreService().createService(morrfService);
}

void seedServices() async {
  var collection = FirebaseFirestore.instance.collection('services');
  var snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
  }

  List<String> uid = [
    'gwSSMEnzvWZuDDn5GMu8U4YKPzq1',
    'orvM6Mkz5XVAVzNmERcEu4SxwOa2'
  ];

  for (var i = 0; i < uid.length; i++)
    for (var j = 0; j < 10; j++) {
      seedServicesSeed(uid[i]);
    }
  print("seeded services");
}
