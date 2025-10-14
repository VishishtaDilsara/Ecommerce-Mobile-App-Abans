import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_abans/models/category_model.dart';

class Categories {
  static List<Category> list = [
    Category(id: 'tv', name: 'TV', icon: FontAwesomeIcons.tv),
    Category(id: 'av', name: 'Audio and Video', icon: FontAwesomeIcons.video),
    Category(
      id: 'home_appl',
      name: 'Home Appliances',
      icon: FontAwesomeIcons.house,
    ),
    Category(
      id: 'kitchen_appl',
      name: 'Kitchen Appliances',
      icon: FontAwesomeIcons.kitchenSet,
    ),
  ];

  Category findCategoryById(String id) {
    return list.firstWhere((element) => element.id == id);
  }
}
