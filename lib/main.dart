import 'package:flutter_precio_luz/ui/pages/home.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'controllers/app_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class AppRoutes {
  AppRoutes._();
  static const String home = '/main';
  static final routes = [
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
