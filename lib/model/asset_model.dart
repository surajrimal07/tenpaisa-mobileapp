class Asset {
  String symbol;
  String name;
  String? category;
  String? sector;
  String? eps;
  String? bookvalue;
  String? pe;
  String? percentchange;
  String? ltp;
  String? unit; //optional
  String? totaltradedquantity;
  String? previousclose;
  String? turnover;

  Asset({
    required this.symbol,
    required this.name,
    this.category,
    this.sector,
    this.eps,
    this.bookvalue,
    this.pe,
    this.percentchange,
    this.ltp,
    this.unit,
    this.totaltradedquantity,
    this.previousclose,
    this.turnover,
  });
}
