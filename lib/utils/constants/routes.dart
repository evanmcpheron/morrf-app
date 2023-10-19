import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:morrf/screen/client%20screen/client%20home/client_home.dart';
import 'package:morrf/screen/seller%20screen/main_screens.dart';
import 'package:morrf/screen/seller%20screen/seller%20home/seller_home.dart';
import 'package:morrf/screen/splash%20screen/mt_splash_screen.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => const SplashScreen()),
  GetPage(name: '/client', page: () => ClientHome()),
  GetPage(name: '/trainer', page: () => SellerHome())
];
