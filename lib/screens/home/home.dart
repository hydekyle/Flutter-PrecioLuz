import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/models.dart';
import 'package:flutter_precio_luz/widgets/PriceList/view.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PriceList(),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navbarIndex = Get.find<AppController>().navbarIndex;
    return TitledBottomNavigationBar(
        currentIndex: navbarIndex.value,
        onTap: (index) {
          navbarIndex.value = index;
        },
        items: [
          TitledNavigationBarItem(
            title: const Text('Home1'),
            icon: const Icon(Icons.home),
          ),
          TitledNavigationBarItem(
            title: const Text('Home'),
            icon: const Icon(Icons.home),
          ),
          TitledNavigationBarItem(
            title: const Text('Home2'),
            icon: const Icon(Icons.home),
          ),
        ]);
  }
}
