import 'package:flutter/foundation.dart';

class Shoe {
  final String title;
  final String image;
  final int cost;
  final int rating;
  final String brand;
  final String id;
  final int count;
  final List<String> inCart;
  final List<String> likes;
  final List<String> comments;
  Shoe({
    required this.title,
    required this.image,
    required this.cost,
    required this.rating,
    required this.brand,
    required this.id,
    required this.count,
    required this.inCart,
    required this.likes,
    required this.comments,
  });

  Shoe copyWith({
    String? title,
    String? image,
    int? cost,
    int? rating,
    String? brand,
    String? id,
    int? count,
    List<String>? inCart,
    List<String>? likes,
    List<String>? comments,
  }) {
    return Shoe(
      title: title ?? this.title,
      image: image ?? this.image,
      cost: cost ?? this.cost,
      rating: rating ?? this.rating,
      brand: brand ?? this.brand,
      id: id ?? this.id,
      count: count ?? this.count,
      inCart: inCart ?? this.inCart,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'cost': cost,
      'rating': rating,
      'brand': brand,
      'id': id,
      'count': count,
      'inCart': inCart,
      'likes': likes,
      'comments': comments,
    };
  }

  factory Shoe.fromMap(Map<String, dynamic> map) {
    return Shoe(
      title: map['title'] as String,
      image: map['image'] as String,
      cost: map['cost'] as int,
      rating: map['rating'] as int,
      brand: map['brand'] as String,
      id: map['id'] as String,
      count: map['count'] as int,
      inCart: List<String>.from(map['inCart']),
      likes: List<String>.from(
        (map['likes']),
      ),
      comments: List<String>.from(
        (map['comments']),
      ),
    );
  }

  @override
  String toString() {
    return 'Shoe(title: $title, image: $image, cost: $cost, rating: $rating, brand: $brand, id: $id, count: $count, inCart: $inCart, likes: $likes, comments: $comments)';
  }

  @override
  bool operator ==(covariant Shoe other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.image == image &&
        other.cost == cost &&
        other.rating == rating &&
        other.brand == brand &&
        other.id == id &&
        other.count == count &&
        listEquals(other.inCart, inCart) &&
        listEquals(other.likes, likes) &&
        listEquals(other.comments, comments);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        image.hashCode ^
        cost.hashCode ^
        rating.hashCode ^
        brand.hashCode ^
        id.hashCode ^
        count.hashCode ^
        inCart.hashCode ^
        likes.hashCode ^
        comments.hashCode;
  }
}
