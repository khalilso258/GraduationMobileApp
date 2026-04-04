class OfferModel {
  final int id; // إضافة الحقل id
  final String sourceType;
  final String messages;
  final String calls;
  final String internet;
  final String price;
  final String date;

  OfferModel({
    required this.id,
    required this.sourceType,
    required this.messages,
    required this.calls,
    required this.internet,
    required this.price,
    required this.date,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      id: json['id'] ?? 0,
      sourceType: json['source_type'] ?? 'Unknown',
      messages: "${json['final_sms'] ?? 0} SMS",
      calls: "${json['final_calls'] ?? 0} min",
      internet: "${((json['final_internet'] ?? 0) / 1024).toStringAsFixed(2)} GB",
      price: "${json['final_price'] ?? 0} SYP",
      date: json['final_date'] ?? 'Unknown',
    );
  }
}
