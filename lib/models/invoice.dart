// invoice.dart

class Invoice {
  final int id;
  final int customerId;
  final DateTime date;
  final int total;
  final String creditcard;

  Invoice({
    required this.id,
    required this.customerId,
    required this.date,
    required this.total,
    required this.creditcard,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      customerId: json['customerId'],
      date: DateTime.parse(json['date']),
      total: json['total'].toDouble(),
      creditcard: json['creditcard'],
    );
  }
}
