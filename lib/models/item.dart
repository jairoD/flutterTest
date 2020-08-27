import 'dart:convert';

class Item {
  String name;
  String description;
  String price;
  String image;
  Item({
    this.name,
    this.description,
    this.price,
    this.image,
  });

  Item copyWith({
    String name,
    String description,
    String price,
    String image,
  }) {
    return Item(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Item(
      name: map['name'],
      description: map['description'],
      price: map['price'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Item(name: $name, description: $description, price: $price, image: $image)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Item &&
        o.name == name &&
        o.description == description &&
        o.price == price &&
        o.image == image;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        image.hashCode;
  }
}
