class Product {
  final int id;
  final String title;
  final String description;
  final num price;
  final String brand;
  final String category;
  final num rating;
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.brand,
    required this.category,
    required this.rating,
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: json['price'] as num,
      brand: json['brand'] as String,
      category: json['category'] as String,
      rating: json['rating'] as num,
      thumbnail: json['thumbnail'] as String,
    );
  }
}