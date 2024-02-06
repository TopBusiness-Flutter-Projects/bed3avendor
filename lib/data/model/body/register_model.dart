class RegisterModel {
  String? fName;
  String? lName;
  String? phone;
  String? email;
  String? password;
  String? confirmPassword;
  String? shopName;
  String? shopAddress;
  int? cityId;
  RegisterModel(
      {this.fName,
      this.lName,
      this.phone,
      this.cityId,
      this.email,
      this.password,
      this.confirmPassword,
      this.shopName,
      this.shopAddress});
}
