import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/ui/widgets/NavbarBottom/navbar_bottom.dart';
import 'package:flutter_precio_luz/ui/widgets/PriceHighestAndLowest/price_highest_and_lowest.dart';
import 'package:flutter_precio_luz/ui/widgets/PriceList/price_list.dart';
import 'dart:math' as math;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: bodyHome()),
      bottomNavigationBar: const NavbarButtom(),
    );
  }

  Widget bodyHome() {
    return Column(
      children: [
        Flexible(
          flex: 6,
          child: Stack(
            children: const [
              Center(child: PriceList()),
            ],
          ),
        ),
      ],
    );
  }
}
