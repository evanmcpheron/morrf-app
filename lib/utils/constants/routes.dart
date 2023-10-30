import 'package:get/route_manager.dart';
import 'package:morrf/screen/client_screen/client_home/client_home.dart';
import 'package:morrf/screen/trainer_screen/trainer_home/trainer_home.dart';
import 'package:morrf/screen/trainer_screen/trainer_services/create_new_service.dart';
import 'package:morrf/screen/global_screen/splash_screen/mt_splash_screen.dart';

List<GetPage> routes = [
  GetPage(name: '/', page: () => const SplashScreen()),
  GetPage(name: '/client', page: () => ClientHome()),
  GetPage(name: '/trainer', page: () => TrainerHome())
];
