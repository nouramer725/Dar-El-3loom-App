class BalanceModel {
  final String subject;
  final String teacher;
  final String date;
  final int price;
  final int paid;
  final int remaining;

  BalanceModel({
    required this.subject,
    required this.teacher,
    required this.date,
    required this.price,
    required this.paid,
    required this.remaining,
  });

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(
      subject: json['n_mada']?.toString() ?? '',
      teacher: json['n_mod']?.toString() ?? '',
      date: json['dates']?.toString() ?? '',

      price: (json['price'] as num?)?.toInt() ?? 0,
      paid: (json['cash_in'] as num?)?.toInt() ?? 0,
      remaining: (json['r'] as num?)?.toInt() ?? 0,
    );
  }
}
