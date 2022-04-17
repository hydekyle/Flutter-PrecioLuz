import 'package:flutter_precio_luz/screens/home/home.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();
  static const String home = '/main';

  static final routes = [
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
