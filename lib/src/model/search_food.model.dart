class FoodItem {
  final String title;
  final String description;
  final String imageUrl;
  final String restaurantName;

  FoodItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.restaurantName,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? 'https://via.placeholder.com/100',
      restaurantName: json['restaurant']['title'] ?? '',
    );
  }
}
