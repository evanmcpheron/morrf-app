import 'package:flutter/material.dart';
import 'package:morrf/models/service/morrf_service.dart';

class Constants {
  static const logoPath = 'assets/images/logo.png';
  static const loginEmotePath = 'assets/images/loginEmote.png';
  static const googlePath = 'assets/images/google.png';

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';

  static const tabWidgets = [
    // FeedScreen(),
    // AddPostScreen(),
  ];

  static const IconData up =
      IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null);
  static const IconData down =
      IconData(0xe801, fontFamily: 'MyFlutterApp', fontPackage: null);

  static const awardsPath = 'assets/images/awards';

  static const availableGenders = ["", "Male", "Female"];

  static String currencySign = '\$';

//__________Gender______________________________________________________
  static List<String> gender = [
    "",
    'Male',
    'Female',
  ];
  static String selectedGender = '';

  static List<String> catName = [
    'Personal Trainer',
    'Nutritionist',
    'Life Coach',
    '',
  ];
//__________performance_period___________________________________________________
  static List<String> period = [
    'Last Month',
    'This Month',
  ];
  static String selectedPeriod = 'Last Month';

//__________statistics_period___________________________________________________
  static List<String> staticsPeriod = [
    'Last Month',
    'This Month',
  ];
  static String selectedStaticsPeriod = 'Last Month';

//__________statistics_period___________________________________________________
  static List<String> earningPeriod = [
    'Last Month',
    'This Month',
  ];
  static String selectedEarningPeriod = 'Last Month';

//__________SubCategory______________________________________________________
  static List<String> subcategory = [
    'Flutter',
    'React Native',
    'Java',
  ];

  static String selectedSubCategory = 'Flutter';

//__________ServiceType______________________________________________________
  static List<String> serviceType = [
    'Online',
    'Offline',
  ];

  String selectedServiceType = 'Online';

//__________time______________________________________________________
  static List<int> deliveryTime = [
    3,
    5,
    7,
    12,
    15,
    20,
  ];

  static List<String> titleList = [
    'Active',
    'Pending',
    'Completed',
    'Cancelled',
  ];

  static List<String> deliveryTimeList = [
    '3 days',
    '5 days',
    '7 days',
    '12 days',
    '15 days',
    '20 days',
  ];

  static String selectedDeliveryTimeList = '3 days';

  static List<String> revisionTime = [
    '1 time',
    '2 time',
    '3 time',
    '4 time',
  ];

  static bool isFavorite = false;

  static String selectedRevisionTime = '1 time';

  static List<Option> list = [
    Option("Responsive design", false),
    Option("Responsive design", false),
    Option("Responsive design", false),
    Option("Prototype", false),
    Option("Prototype", false),
    Option("Prototype", false),
    Option("Source file", false),
    Option("Source file", false),
    Option("Source file", false),
  ];
}
