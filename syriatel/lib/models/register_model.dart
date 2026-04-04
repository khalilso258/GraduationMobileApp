class RegisterRequestModel {
  final String signupDate;
  final String username;
  final String password;
  final String phoneNumber;
  final String gender;
  final String location;
  final String lineType;
  final int age;

  RegisterRequestModel({
    required this.username,
    required this.password,
    required this.phoneNumber,
    required this.gender,
    required this.location,
    required this.lineType,
    required this.signupDate,
    required this.age,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'phone_number': phoneNumber,
    'gender': gender,
    'location': location,
    'line_type': lineType,
    'signup_date': signupDate,
    'age': age,
  };
}
