class Cart {
  final String id;
  final String uid;
  final String shoeId;
  final String shoeTitle;
  final String shoeImage;
  final String size;
  final String shoeBrand;
  final int cost;
  Cart({
    required this.id,
    required this.uid,
    required this.shoeId,
    required this.shoeTitle,
    required this.shoeImage,
    required this.size,
    required this.shoeBrand,
    required this.cost,
  });

  Cart copyWith({
    String? id,
    String? uid,
    String? shoeId,
    String? shoeTitle,
    String? shoeImage,
    String? size,
    String? shoeBrand,
    int? cost,
  }) {
    return Cart(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      shoeId: shoeId ?? this.shoeId,
      shoeTitle: shoeTitle ?? this.shoeTitle,
      shoeImage: shoeImage ?? this.shoeImage,
      size: size ?? this.size,
      shoeBrand: shoeBrand ?? this.shoeBrand,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'shoeId': shoeId,
      'shoeTitle': shoeTitle,
      'shoeImage': shoeImage,
      'size': size,
      'shoeBrand': shoeBrand,
      'cost': cost,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] as String,
      uid: map['uid'] as String,
      shoeId: map['shoeId'] as String,
      shoeTitle: map['shoeTitle'] as String,
      shoeImage: map['shoeImage'] as String,
      size: map['size'] as String,
      shoeBrand: map['shoeBrand'] as String,
      cost: map['cost'] as int,
    );
  }

  @override
  String toString() {
    return 'Cart(id: $id, uid: $uid, shoeId: $shoeId, shoeTitle: $shoeTitle, shoeImage: $shoeImage, size: $size, shoeBrand: $shoeBrand, cost: $cost)';
  }

  @override
  bool operator ==(covariant Cart other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.uid == uid &&
        other.shoeId == shoeId &&
        other.shoeTitle == shoeTitle &&
        other.shoeImage == shoeImage &&
        other.size == size &&
        other.shoeBrand == shoeBrand &&
        other.cost == cost;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        shoeId.hashCode ^
        shoeTitle.hashCode ^
        shoeImage.hashCode ^
        size.hashCode ^
        shoeBrand.hashCode ^
        cost.hashCode;
  }
}
