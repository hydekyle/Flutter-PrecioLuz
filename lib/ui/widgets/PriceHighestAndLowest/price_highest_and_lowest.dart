import 'package:flutter/material.dart';
import 'package:flutter_precio_luz/models/price_data_model.dart';

class PriceHighestAndLowest extends StatelessWidget {
  const PriceHighestAndLowest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 5,
          child: Container(
            color: Colors.green,
            child: Text("Bajo"),
          ),
        ),
        Flexible(
          flex: 5,
          child: Container(
            color: Colors.red,
            child: Text("alto"),
          ),
        ),
      ],
    );
  }
}
