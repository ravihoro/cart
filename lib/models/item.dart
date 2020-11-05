class ItemList {
  final List<Item> items;

  ItemList({this.items});

  factory ItemList.fromJson(List<dynamic> parsedJson) {
    List<Item> items = new List<Item>();
    items = parsedJson.map((i) => Item.fromJson(i)).toList();
    return new ItemList(items: items);
  }
}

class Item {
  int id;
  String title;
  double price;
  String description;
  String category;
  String imageUrl;
  bool isFavorite;

  Item(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.imageUrl,
      this.isFavorite});

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
