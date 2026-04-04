class ProfileModel {
  final String phoneNumber;
  final int age;
  final String gender;
  final String lineType;
  final String location;
  final String signupDate;
  final List<MonthlyUsage> monthlyUsage;
  final String? name; // افتراضياً

  ProfileModel({
    required this.phoneNumber,
    required this.age,
    required this.gender,
    required this.lineType,
    required this.location,
    required this.signupDate,
    required this.monthlyUsage,
    this.name,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      phoneNumber: json['phone_number'],
      age: json['age'],
      gender: json['gender'],
      lineType: json['line_type'],
      location: json['location'],
      signupDate: json['signup_date'],
      monthlyUsage: json['monthly_usage'] != null
          ? (json['monthly_usage'] as List).map((e) => MonthlyUsage.fromJson(e)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'phone_number': phoneNumber,
      'age': age,
      'gender': gender,
      'line_type': lineType,
      'location': location,
      'signup_date': signupDate,
      'monthly_usage': monthlyUsage.map((e) => e.toJson()).toList(),
    };
  }
}

class MonthlyUsage {
  final String month;
  final double totalInternet;
  final int totalCalls;
  final int totalSms;

  MonthlyUsage({
    required this.month,
    required this.totalInternet,
    required this.totalCalls,
    required this.totalSms,
  });

  factory MonthlyUsage.fromJson(Map<String, dynamic> json) {
    return MonthlyUsage(
      month: json['month'],
      totalInternet: (json['total_internet'] as num).toDouble(),
      totalCalls: json['total_calls'],
      totalSms: json['total_sms'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'total_internet': totalInternet,
      'total_calls': totalCalls,
      'total_sms': totalSms,
    };
  }
}
