class Item {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String imageUrl;
  final bool isFavorite;

  const Item({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.imageUrl,
    this.isFavorite,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      category: json['category'],
      imageUrl: json['image'],
      isFavorite: false,
    );
  }
}
