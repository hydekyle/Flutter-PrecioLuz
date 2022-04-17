//import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:flutter_precio_luz/home.dart';
import 'package:flutter_precio_luz/models.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<AppController>(AppController(), permanent: true);
    return GetMaterialApp(
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
