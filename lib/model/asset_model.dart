// class Asset {
//   String symbol;
//   String name;
//   String? category;
//   String? sector;
//   double? eps;
//   double? bookvalue;
//   double? pe;
//   double? percentchange;
//   double ltp;
//   double? totaltradedquantity;
//   double? previousclose;

//   Asset(
//     this.symbol,
//     this.name,
//     this.category,
//     this.sector,
//     this.eps,
//     this.bookvalue,
//     this.pe,
//     this.ltp,
//     this.percentchange,
//     this.totaltradedquantity,
//     this.previousclose,
//   );
// }

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
  });
}
