import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/models.dart';
import 'package:get/get.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({Key? key, required this.price}) : super(key: key);
  final Price price;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
        children: [
          Text(price.date),
          Text(price.hour),
          Text(price.price.toString()),
        ],
      ),
    );
  }
}
