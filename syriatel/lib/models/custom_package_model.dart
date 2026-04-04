class CustomPackage {
  final int internet;
  final int calls;
  final int sms;
  final int price;

  CustomPackage({
    required this.internet,
    required this.calls,
    required this.sms,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'internet': internet,
      'calls': calls,
      'sms': sms,
      'price': price,
    };
  }

  factory CustomPackage.fromJson(Map<String, dynamic> json) {
    return CustomPackage(
      internet: json['internet'] ?? 0,
      calls: json['calls'] ?? 0,
      sms: json['sms'] ?? 0,
      price: json['price'] ?? 0,
    );
  }
}
