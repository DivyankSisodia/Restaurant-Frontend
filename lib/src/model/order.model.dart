class Food {
  final String title;
  final int price;
  final int quantity;
  final String restaurant;
  final String image;
  final int totalPrice;

  Food({
    required this.title,
    required this.price,
    required this.quantity,
    required this.restaurant,
    required this.image,
  }) : totalPrice = price * quantity;

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      title: json['food']['title'],
      price: json['food']['price'],
      quantity: json['quantity'],
      restaurant: json['food']['restaurant'],
      image: json['food']['image'],
    );
  }
}

class OrderItem {
  final String id;
  final List<Food> foods;
  final int totalPrice;

  OrderItem({
    required this.id,
    required this.foods,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    int calculatedTotalPrice = 0;
    final foods = (json['foods'] as List).map((foodJson) {
      final food = Food.fromJson(foodJson);
      calculatedTotalPrice += food.totalPrice;
      return food;
    }).toList();

    return OrderItem(
      id: json['_id'],
      foods: foods,
      totalPrice: calculatedTotalPrice,
    );
  }
}

class Order {
  final List<OrderItem> orders;
  final int currentPage;
  final int totalPages;

  Order({required this.orders, required this.currentPage, required this.totalPages});

  factory Order.fromJson(Map<String, dynamic> json) {
    var list = json['orders'] as List;
    List<OrderItem> ordersList = list.map((i) => OrderItem.fromJson(i)).toList();

    return Order(
      orders: ordersList,
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
    );
  }
}
