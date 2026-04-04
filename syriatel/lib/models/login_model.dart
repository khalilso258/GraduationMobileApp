class LoginRequestModel {
  final String phone;
  final String password;

  LoginRequestModel({required this.phone, required this.password});

  Map<String, dynamic> toJson() => {
    'phone_number': phone,
    'password': password,
  };
}

class LoginResponseModel {
  final String token;
  final String refresh;

  LoginResponseModel({required this.token , required this.refresh});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(token: json['access'] , refresh: json['refresh']);
  }
}
