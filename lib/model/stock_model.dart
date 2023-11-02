class Stock {
  String? iconUrl;
  String? symbol;
  String? name;
  String? price;
  String? change;
  String? color;

  Stock(
      {this.iconUrl,
      this.symbol,
      this.name,
      this.price,
      this.change,
      this.color});

  Stock.fromJson(Map<String, dynamic> json) {
    iconUrl = json['iconUrl'];
    symbol = json['symbol'];
    name = json['name'];
    price = json['price'];
    change = json['change'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iconUrl'] = iconUrl;
    data['symbol'] = symbol;
    data['name'] = name;
    data['price'] = price;
    data['change'] = change;
    data['color'] = color;
    return data;
  }
}
