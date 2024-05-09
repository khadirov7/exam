

class ProductModel {
  final String id;
  final String name;
  final double price;
  final bool isDiscount;
  late final int count;
  final bool isFavourite;
  final String description;
  final Category category;
  final int orders;
  final String images;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.isDiscount,
    required this.count,
    required this.isFavourite,
    required this.description,
    required this.category,
    required this.orders,
    required this.images,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    double? price,
    bool? isDiscount,
    int? count,
    bool? isFavourite,
    String? description,
    Category? category,
    int? orders,
    String? images,
  }) {
    return ProductModel(
      id: id ?? this.id,
      isDiscount: isDiscount ?? this.isDiscount,
      name: name ?? this.name,
      price: price ?? this.price,
      count: count ?? this.count,
      isFavourite: isFavourite ?? this.isFavourite,
      description: description ?? this.description,
      category: category ?? this.category,
      orders: orders ?? this.orders,
      images: images ?? this.images,
    );
  }
  Map<String, dynamic> toJsonForUpdate() => {
    "count": count,
    "orders" : orders,
  };

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'isDiscount': isDiscount,
      'name': name,
      'price': price,
      'count': count,
      'isFavourite': isFavourite,
      'description': description,
      'category': category.toString().split('.').last,
      'orders': orders,
      'images': images,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as String? ?? "",
      isDiscount: json['isDiscount'] as bool? ?? false,
      name: json['name'] as String? ?? "",
      price: (json['price'] as num? ?? 0).toDouble(),
      count: (json['count'] as num? ?? 0).toInt(),
      isFavourite: json['isFavourite'] as bool? ?? false,
      description: json['description'] as String? ?? "",
      category: Category.values.firstWhere(
            (c) => c.toString().split('.').last == json['category'],
        orElse: () => Category.Hammasi,
      ),
      orders: (json['orders'] as num? ?? 0).toInt(),
      images: json['images'] as String? ?? '',
    );
  }
}
enum Category {
  Hammasi,
  Qurilmalar,
  Akksessuarlar,
  Kiyimlar,
  Kitoblar,
  Mebellar,
}

List<String> categoryTech = [
  "Tablets",
  "Phones",
  "iPads",
  "iPod",
];