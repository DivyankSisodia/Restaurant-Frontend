// food_filter.dart

// ignore_for_file: file_names


class FoodFilter {
  static List<Map<String, dynamic>> filterFoods(
    List<Map<String, dynamic>> foods,String keyword
  )
  {
    if (keyword.isEmpty) {
      return foods;
    } else {
      return foods
          .where((food) => food['title']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    }
  }
}

// main logic

// void filterFoods(String keyword) {
//   List<Map<String, dynamic>> results = [];
//   if (keyword.isEmpty) {
//     results = widget.restaurant.foods;
//   } else {
//     results = listOfFoods
//         .where((food) => food['title']
//             .toString()
//             .toLowerCase()
//             .contains(keyword.toLowerCase()))
//         .toList();
//   }
//   setState(() {
//     listOfFoods = results;
//   });
// }
