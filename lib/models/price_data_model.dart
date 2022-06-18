class PriceData {
  final String date, hour, market, units;
  final bool isCheap, isUnderAvg;
  final double price;
  late double cheapRate;

  PriceData(this.date, this.hour, this.market, this.units, this.isCheap,
      this.isUnderAvg, this.price);

  PriceData.empty()
      : date = "date",
        hour = "hour",
        market = "market",
        units = "units",
        isCheap = false,
        isUnderAvg = false,
        price = 0;

  PriceData.fromJSON(Map<String, dynamic> json)
      : date = json["date"],
        hour = json["hour"],
        market = json["market"],
        units = json["units"],
        isCheap = json["is-cheap"],
        isUnderAvg = json["is-under-avg"],
        price = json["price"];
}
