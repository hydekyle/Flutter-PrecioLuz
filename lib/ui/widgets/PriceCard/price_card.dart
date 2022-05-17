import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/models/price_data_model.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({Key? key, required this.priceData}) : super(key: key);
  final PriceData priceData;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
        children: [
          Text(priceData.date),
          Text(priceData.hour),
          Text(priceData.price.toString()),
        ],
      ),
    );
  }
}
