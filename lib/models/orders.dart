// order.dart

class Orders{
  final int id;
  final int songId;
  final int invoiceId;

  Orders({
    required this.id,
    required this.songId,
    required this.invoiceId,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      id: json['id'],
      songId: json['songId'],
      invoiceId: json['invoiceId'],
    );
  }
}
