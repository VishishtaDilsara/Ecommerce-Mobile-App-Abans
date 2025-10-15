class ProductModel {
  final String id;
  final String name;
  final String description;
  final String categoryId;
  final double price;
  final List<String> images;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.description,
    required this.images,
    required this.name,
    required this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      categoryId: json['categoryId'],
      description: json['description'],
      images: (json['images'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      name: json['name'],
      price: json['price'],
    );
  }

  // product model to json

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'description': description,
      'images': images,
      'name': name,
      'price': price,
    };
  }
}
