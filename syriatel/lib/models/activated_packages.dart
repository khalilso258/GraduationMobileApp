class ActivatedPackageModel {
  final int id;
  final String packageName;
  final double internetLimit;
  final int callLimit;
  final int smsLimit;
  final double price;
  final String source;
  final String activationDate;


  ActivatedPackageModel({
    required this.id,
    required this.packageName,
    required this.internetLimit,
    required this.callLimit,
    required this.smsLimit,
    required this.price,
    required this.source,
    required this.activationDate,

  });

  factory ActivatedPackageModel.fromJson(Map<String, dynamic> json) {
    return ActivatedPackageModel(
      id: json['id'] ?? 0,
      packageName: json['package_name'] ?? 'Unknown',
      internetLimit: ((json['internet_limit'] ?? 0).toDouble() / 1024).toDouble(),
      callLimit: (json['call_limit'] ?? 0).toInt(),
      smsLimit: (json['sms_limit'] ?? 0).toInt(),
      price: (json['price'] ?? 0).toDouble(),
      source: json['source'] ?? 'Unknown',
      activationDate: json['activation_date'] ?? 'Unknown',

    );
  }
}
