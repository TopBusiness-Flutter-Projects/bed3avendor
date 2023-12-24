class AddNewProductFromAdminToSeller {
  dynamic data;
  String message;
  int code;

  AddNewProductFromAdminToSeller({
    required this.data,
    required this.message,
    required this.code,
  });

  factory AddNewProductFromAdminToSeller.fromJson(Map<String, dynamic> json) =>
      AddNewProductFromAdminToSeller(
        data: json["data"],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "message": message,
        "code": code,
      };
}
