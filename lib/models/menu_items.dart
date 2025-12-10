class MenuModel {
  final String id;
  final String name;
  final String description;
  final int price;
  final String image;

  MenuModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory MenuModel.fromJson(Map<String, dynamic> map, String id) {
    return MenuModel(
      id: id,
      name: map['name'] ?? 'Tanpa Nama',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toInt(),
      image: map['image'] ?? map['imageUrl'] ?? '', // PRIORITAS image
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
}
