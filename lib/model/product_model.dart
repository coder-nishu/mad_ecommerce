class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final List<String> imageUrl;
  final double rating;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.rating,
    required this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      imageUrl: List<String>.from(json['imageUrl']),
      rating: (json['rating'] as num).toDouble(),
      isFavorite: json['isFavorite'],
    );
  }
}