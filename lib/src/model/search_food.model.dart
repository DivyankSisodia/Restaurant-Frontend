class FoodItem {
  final String title;
  final String description;
  final String imageUrl;

  FoodItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? 'https://via.placeholder.com/100',
    );
  }
}
