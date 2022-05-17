class PriceData {
  final String date, hour, market, units;
  final bool isCheap, isUnderAvg;
  final double price;

  PriceData(this.date, this.hour, this.market, this.units, this.isCheap,
      this.isUnderAvg, this.price);

  PriceData.fromJSON(Map<String, dynamic> json)
      : date = json["date"],
        hour = json["hour"],
        market = json["market"],
        units = json["units"],
        isCheap = json["is-cheap"],
        isUnderAvg = json["is-under-avg"],
        price = json["price"];
}
