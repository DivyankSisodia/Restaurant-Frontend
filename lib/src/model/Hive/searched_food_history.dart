import 'package:hive/hive.dart';

part 'searched_food_history.g.dart';

@HiveType(typeId: 0)
class SearchedFoodHistory extends HiveObject {
  @HiveField(0)
  late String title;
}
