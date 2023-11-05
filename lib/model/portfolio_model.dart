class Portfolio {
  String name;
  String type; //bond, stocks, fd?
  String waccvalue;
  String cvalue; //what's the current value of the portfolio?
  String
      portstyle; // what's the user endgoal with this portfolio? do we even need this?
  String rebalancing; // is rebalancing required in this portfolio
  String assethold; //what are the asset user holding in this portfolio?
  Portfolio(this.name, this.type, this.waccvalue, this.cvalue, this.portstyle,
      this.rebalancing, this.assethold);
}
