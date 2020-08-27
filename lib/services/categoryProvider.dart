import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  String category = "all";

  void changeCategory(String newCategory) {
    category = newCategory;
    notifyListeners();
  }
}
