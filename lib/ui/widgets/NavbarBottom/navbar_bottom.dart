import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/controllers/app_controller.dart';
import 'package:get/get.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';

class NavbarButtom extends StatelessWidget {
  const NavbarButtom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navbarIndex = Get.find<AppController>().navbarIndex;
    return TitledBottomNavigationBar(
        currentIndex: navbarIndex.value,
        activeColor: Theme.of(context).colorScheme.onPrimary,
        reverse: true,
        onTap: (index) {
          navbarIndex.value = index;
        },
        items: [
          TitledNavigationBarItem(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: const Text('HOY'),
            icon: const Icon(Icons.today),
          ),
        ]);
  }
}
