class ReviewModel {
  final int id;
  final String description;
  final double rating;
  final int customerId;
  final int productId;
  final String createdAt;
  final String updatedAt;
  final String customerName;

  ReviewModel({
    required this.id,
    required this.description,
    required this.rating,
    required this.customerId,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
    required this.customerName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? "",
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : double.tryParse(json['rating'].toString()) ?? 0.0,
      customerId: json['customer_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      customerName: json['profile']?['cus_name'] ?? "Anonymous",
    );
  }
}
