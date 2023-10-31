import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:morrf/models/service/morrf_faq.dart';
import 'package:morrf/models/service/morrf_service.dart';
import 'package:morrf/services/firestore/firestore_service.dart';
import 'package:morrf/utils/format.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uuid/uuid.dart';
import 'package:faker/faker.dart';

final random = RandomGenerator(seed: 63833423);
final fakerFa = Faker.withGenerator(random);

void seedServicesSeed(String trainerId, String trainerName) {
  List<String> categories = ["Personal Trainer", "Nutrition"];
  List<String> suncategories = ["Yoga", "Meal Prep"];
  List<String> serviceTypes = ["Online", "In Person"];
  List<String> photoUrls = [
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/product_images%2F6c175130-044f-4520-9adc-693a430c9249.jpg?alt=media&token=d9170b8b-6bee-4823-aa0d-c693b886074f&_gl=1*kns9bz*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODY3MDI5MS43OS4xLjE2OTg2NzA0NTguNTUuMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/product_images%2F7220fb6d-caa5-44cf-845b-c3ffccb7ddb7.jpg?alt=media&token=ad6dfb19-87d2-4f6d-a120-e39200b70d62&_gl=1*rr2jvw*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODY3MDI5MS43OS4xLjE2OTg2NzA1MDMuMTAuMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/product_images%2Faaea0d69-ad9e-4e03-86b8-b07185b3e76e.jpg?alt=media&token=43ef3a01-109c-4d75-8547-dfc2010fca5c&_gl=1*gzh6w9*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODY3MDI5MS43OS4xLjE2OTg2NzA1NDguNjAuMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/product_images%2Fb4b16efb-db38-4ecb-b9f6-3e5d0ea12562.jpg?alt=media&token=6f6276c3-accd-439f-9924-6c0186b79563&_gl=1*hvzyr5*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODY3MDI5MS43OS4xLjE2OTg2NzA1NjYuNDIuMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/product_images%2Fe7f341ea-2608-41ea-815b-50e7712b691e.jpg?alt=media&token=13cc21d2-ff3f-479d-8088-b552bc328ede&_gl=1*6mpoc7*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODY3MDI5MS43OS4xLjE2OTg2NzA1ODAuMjguMC4w",
    "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/product_images%2Fec28a96f-eca2-4719-b567-7c4b00761c7f.jpg?alt=media&token=c11bf9c4-f128-48df-b2cb-e5c8662b7b7d&_gl=1*k4tg4p*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODY3MDI5MS43OS4xLjE2OTg2NzA1OTYuMTIuMC4w"
  ];
  photoUrls.shuffle();
  String heroUrl = photoUrls[Random().nextInt(5)];

  String title = fakerFa.lorem.words(Random().nextInt(8) + 2).join(' ');
  String category = categories[Random().nextInt(1)];
  String subcategory = suncategories[Random().nextInt(1)];
  String serviceType = serviceTypes[Random().nextInt(1)];
  String description = fakerFa.lorem.sentences(2).join(' ');
  List<Option> options = createOptionsList();

  Map<String, Tier> tiers = {
    "basic": createSeedTier(options),
    "standard": createSeedTier(options),
    "premium": createSeedTier(options),
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
      trainerName: trainerName,
      trainerProfileImage:
          "https://firebasestorage.googleapis.com/v0/b/mickiefitness.appspot.com/o/user_profile.jpg?alt=media&token=deba737f-c8c1-4a2e-bec5-a4474913e102&_gl=1*dljxr1*_ga*MjkyNzM5ODM3LjE2ODkyNzc3MjY.*_ga_CW55HF8NVT*MTY5ODc2OTc2OC44NS4xLjE2OTg3NzE4NTMuNTUuMC4w",
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

Tier createSeedTier(List<Option> options) {
  List<int> deliveryTimes = [3, 5, 7, 12, 15, 20];
  int deliveryTime = deliveryTimes[Random().nextInt(5)];
  bool isVisible = random.boolean();
  int revisions = Random().nextInt(5);
  double price = "${Random().nextInt(200)}.${Random().nextInt(99)}".toDouble();
  String title = fakerFa.lorem.words(Random().nextInt(4) + 2).join(' ');
  return Tier(
    title: title,
    revisions: revisions,
    options: options,
    deliveryTime: deliveryTime,
    isVisible: isVisible,
    price: formatPrice(price),
  );
}

List<Option> createOptionsList() {
  List<Option> optionList = [];
  for (int i = 0; i < Random().nextInt(5); i++) {
    bool isSelected = random.boolean();
    String title = fakerFa.lorem.words(Random().nextInt(3) + 2).join(' ');
    optionList.add(Option(title, isSelected));
  }
  return optionList;
}

void seedServices() async {
  var collection = FirebaseFirestore.instance.collection('services');
  var snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
  }

  List<String> uid = [
    '5VJNmogTMGQuzGTVcQxWUvXirnS2',
    'O1r7P1328DSXJjHbDri38CxAs2f2'
  ];
  List<String> names = ['Evan McPheron', 'Trainer Morrf'];

  for (var i = 0; i < uid.length; i++)
    for (var j = 0; j < 10; j++) {
      seedServicesSeed(uid[i], names[i]);
    }
  print("seeded services");
}
