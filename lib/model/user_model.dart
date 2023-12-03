class User {
  String name;
  String picture;
  String phone;
  String email;
  String password;
  String invstyle;
  int defaultport;
  User(
    this.name,
    this.picture,
    this.phone,
    this.email,
    this.password,
    this.invstyle, {
    this.defaultport = 1,
  });
}
