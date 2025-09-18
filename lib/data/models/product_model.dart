class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final String? brand; // Made nullable
  final String category;
  final num rating;
  final String? thumbnail; // Made nullable

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.brand,
    required this.category,
    required this.rating,
    this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String? ?? 'No Description',
      price: json['price'] as num? ?? 0.0,
      brand: json['brand'] as String?,
      category: json['category'] as String? ?? 'Unknown',
      rating: json['rating'] as num? ?? 0.0,
      thumbnail: json['thumbnail'] as String?,
    );
  }
}