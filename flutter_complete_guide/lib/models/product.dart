import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final bool isFavorite;

  Product({
    @required this.id,
    this.title,
    this.description,
    this.price,
    this.imageUrl,
    this.isFavorite = false,
  });

  Product copyWith({
    String id,
    String title,
    String description,
    double price,
    String imageUrl,
    bool isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'description': this.description,
      'price': this.price,
      'imageUrl': this.imageUrl,
    };
  }

  factory Product.fromJson(
      {@required String productId, @required Map<String, dynamic> values}) {
    return Product(
      id: productId,
      title: values['title'],
      description: values['description'],
      price: values['price'],
      imageUrl: values['imageUrl'],
    );
  }
}
